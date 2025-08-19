#!/bin/bash

# Script d'installation complète des dotfiles et applications
set -e

# --- Fonctions utilitaires ---

# Fonction pour détecter le système d'exploitation
get_os() {
    case "$(uname -s)" in
        Darwin)
            echo "darwin"
            ;;
        Linux)
            echo "linux"
            ;;
        *)
            echo "unsupported"
            ;;
    esac
}

# --- Fonctions d'installation par OS ---

install_macos_packages() {
    echo "📦 Installation des paquets pour macOS..."

    # Vérifier si Homebrew est installé
    if ! command -v brew &> /dev/null; then
        echo "-> Installation de Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # Ajouter Homebrew au PATH pour cette session
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    # Installer toutes les applications depuis le Brewfile
    if [ -f "Brewfile" ]; then
        echo "-> Installation des applications depuis Brewfile..."
        brew bundle install --file=Brewfile
    else
        echo "⚠️  Brewfile non trouvé, installation manuelle..."
        brew install git stow starship zoxide zsh-autosuggestions zsh-syntax-highlighting nvm mas ripgrep fd jq
        brew install --cask orbstack warp visual-studio-code spotify notion discord tailscale
        mas install 310633997  # WhatsApp
    fi
}

install_linux_packages() {
    echo "📦 Installation des paquets pour Linux (Debian/Ubuntu)..."

    echo "-> Mise à jour des paquets existants..."
    sudo apt-get update && sudo apt-get upgrade -y

    echo "-> Installation des dépendances de base..."
    sudo apt-get install -y git stow curl zsh build-essential

    echo "-> Installation des outils en ligne de commande..."
    sudo apt-get install -y ripgrep jq fd-find zsh-autosuggestions zsh-syntax-highlighting

    # fd-find est souvent installé sous le nom 'fdfind', on crée un lien symbolique vers 'fd'
    if ! command -v fd &> /dev/null && command -v fdfind &> /dev/null; then
        echo "-> Création du lien symbolique pour fd (fdfind)..."
        sudo ln -s $(which fdfind) /usr/local/bin/fd
    fi

    echo "-> Installation de Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y

    echo "-> Installation de Zoxide..."
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

    echo "-> Installation des outils de développement..."
    # Docker
    echo "-> Installation de Docker..."
    sudo apt-get install -y docker.io
    sudo groupadd -f docker
    sudo usermod -aG docker $USER
    echo "ℹ️  Vous devrez peut-être vous déconnecter/reconnecter pour utiliser Docker sans sudo."

    # Outils graphiques (via Snap)
    echo "-> Installation des applications graphiques via Snap..."
    sudo apt-get install -y snapd

    # VS Code
    echo "-> Installation de Visual Studio Code..."
    sudo snap install --classic code

    # Spotify
    echo "-> Installation de Spotify..."
    sudo snap install spotify

    # Discord
    echo "-> Installation de Discord..."
    sudo snap install discord

    # Tailscale
    echo "-> Installation de Tailscale..."
    curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/$(lsb_release -cs).noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
    curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/$(lsb_release -cs).tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
    sudo apt-get update
    sudo apt-get install tailscale -y

    # Kubectl
    echo "-> Installation de Kubectl..."
    sudo snap install kubectl --classic

    echo "---"
    echo "⚠️  Applications non disponibles sur Linux via ce script :"
    echo "  - OrbStack: Alternative -> Docker (installé)"
    echo "  - Warp: Alternative -> Utilisez votre terminal Linux préféré (GNOME Terminal, Konsole, etc.)"
    echo "  - Notion: Utilisez la version web ou des clients non officiels (ex: snap install notion-snap)."
    echo "  - WhatsApp: Utilisez la version web."
    echo "---"
}

# --- Script principal ---
main() {
    echo "🚀 Installation complète de l'environnement de développement..."

    local os
    os=$(get_os)

    if [[ "$os" == "darwin" ]]; then
        install_macos_packages
    elif [[ "$os" == "linux" ]]; then
        install_linux_packages
    else
        echo "❌ Système d'exploitation non supporté : $(uname -s)"
        exit 1
    fi

    # --- Étapes communes après l'installation des paquets ---

    # Créer les liens symboliques avec Stow
    echo "🔗 Création des liens symboliques..."
    stow .

    # Configurer les permissions SSH
    if [ -d ~/.ssh ]; then
        echo "🔐 Configuration des permissions SSH..."
        chmod 700 ~/.ssh
        if [ -f ~/.ssh/config ]; then
            chmod 600 ~/.ssh/config
            echo "✅ Permissions SSH configurées."
        fi
    else
        echo "⚠️  Le dossier .ssh n'existe pas encore."
    fi

    # --- Installation et configuration de NVM & Node.js ---
    install_nvm_and_node

    # --- Instructions finales ---
    display_final_instructions "$os"

    echo ""
    echo "🎉 Installation terminée !"
}

# --- Fonction pour NVM & Node.js ---
install_nvm_and_node() {
    echo "🟢 Configuration de NVM et Node.js..."

    # Installer NVM
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

    export NVM_DIR="$HOME/.nvm"
    # shellcheck source=/dev/null
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # Installer et utiliser la version LTS de Node.js
    echo "-> Installation de Node.js LTS..."
    nvm install --lts
    nvm use --lts
    nvm alias default node

    echo "✅ Node.js $(node --version) installé et configuré."
}

# --- Fonction pour afficher les instructions finales ---
display_final_instructions() {
    local os=$1

    echo ""
    echo "📝 Prochaines étapes :"
    echo "  - Redémarrez votre terminal pour que tous les changements prennent effet."
    echo "  - Vérifiez Node.js : node --version"
    echo "  - Vérifiez Git : git config --global --list"
    echo "  - Vérifiez la connexion SSH à GitHub : ssh -T git@github.com"

    if [[ "$os" == "darwin" ]]; then
        echo "  - Connectez-vous au Mac App Store pour que 'mas' puisse gérer les applications."
    fi

    echo ""
    echo "🚀 Applications installées :"
    if [[ "$os" == "darwin" ]]; then
        echo "  • OrbStack (Docker), Warp (Terminal), VS Code, Spotify, Notion, Discord, Tailscale, WhatsApp"
    elif [[ "$os" == "linux" ]]; then
        echo "  • Docker, VS Code, Spotify, Discord, Tailscale"
        echo "  • Pour les autres, voir les alternatives mentionnées pendant l'installation."
    fi
}

# Lancer le script principal
main