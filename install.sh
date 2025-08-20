#!/bin/bash

# Script d'installation complète des dotfiles et applications
set -e

echo "🚀 Installation complète de l'environnement de développement..."

# Vérifier si Homebrew est installé
if ! command -v brew &> /dev/null; then
    echo "📦 Installation de Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Ajouter Homebrew au PATH pour cette session
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Installer toutes les applications depuis le Brewfile
if [ -f "Brewfile" ]; then
    echo "📱 Installation des applications depuis Brewfile..."
    brew bundle install --file=Brewfile
else
    echo "⚠️  Brewfile non trouvé, installation manuelle..."
    brew install git stow starship zoxide zsh-autosuggestions zsh-syntax-highlighting nvm mas ripgrep fd jq gnupg pinentry-mac git-who gh
    brew install --cask orbstack warp visual-studio-code spotify notion discord tailscale
    brew install --cask 1password 1password-cli google-chrome
    mas install 310633997  # WhatsApp
fi

# Créer les liens symboliques
echo "🔗 Création des liens symboliques..."
stow .

# Vérifier si le dossier .ssh existe et configurer les permissions
if [ -d ~/.ssh ]; then
    echo "🔐 Configuration des permissions SSH..."
    chmod 700 ~/.ssh

    if [ -f ~/.ssh/config ]; then
        chmod 600 ~/.ssh/config
        echo "✅ Permissions SSH configurées"
    fi
else
    echo "⚠️  Le dossier .ssh n'existe pas encore"
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
fi

# Ajouter la config SSH pour utiliser 1Password comme agent
if ! grep -q "IdentityAgent" ~/.ssh/config 2>/dev/null; then
    echo "🛠️  Ajout de la configuration SSH pour 1Password..."
    cat <<EOF >> ~/.ssh/config

# Utiliser 1Password comme agent SSH
Host *
  IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
EOF
    chmod 600 ~/.ssh/config
fi

# Sign-in à 1Password CLI (ouverture navigateur)
echo "🔑 Connexion au CLI 1Password..."
op signin || echo "ℹ️  Ouvrez 1Password, allez dans Paramètres > Développeurs et activez l'agent SSH. Relancez 'op signin' si besoin."

# Configuration de NVM et Node.js
echo "🟢 Configuration de NVM et Node.js..."
export NVM_DIR="$HOME/.nvm"

# Créer le répertoire NVM s'il n'existe pas
[ ! -d "$NVM_DIR" ] && mkdir -p "$NVM_DIR"

# Charger NVM
if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
    source "/opt/homebrew/opt/nvm/nvm.sh"
    source "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

    # Installer et utiliser la version LTS de Node.js
    echo "📦 Installation de Node.js LTS..."
    nvm install --lts
    nvm use --lts
    nvm alias default node

    echo "✅ Node.js $(node --version) installé et configuré"

    # Installation des paquets globaux
    echo "📦 Installation des paquets globaux Node.js..."
    npm install -g pnpm eslint prettier
else
    echo "⚠️  NVM non trouvé, redémarrez votre terminal et lancez 'nvm install --lts'"
fi

# Recharger la configuration zsh
if [ -f ~/.zshrc ]; then
    echo "♻️  Rechargement de la configuration zsh..."
    source ~/.zshrc 2>/dev/null || echo "ℹ️  Redémarrez votre terminal pour appliquer les changements"
fi

echo ""
echo "🎉 Installation terminée !"
echo ""
echo "📝 Prochaines étapes :"
echo "  - Redémarrez votre terminal"
echo "  - Connectez-vous au Mac App Store pour WhatsApp"
echo "  - Activez l’agent SSH dans 1Password: Préférences → Développeurs → Intégration SSH/GPG"
echo "  - Connectez-vous à 1Password via 'op signin'"
echo "  - Vérifiez Node.js: node --version"
echo "  - Vérifiez la config Git: git config --global --list"
echo "  - Vérifiez la config SSH: ssh-add -L"
echo "  - Testez GitHub: ssh -T git@github.com"
echo ""
echo "🚀 Applications installées :"
echo "  • OrbStack (Docker)"
echo "  • Warp (Terminal)"
echo "  • VS Code"
echo "  • Spotify"
echo "  • Notion"
echo "  • Discord"
echo "  • Tailscale"
echo "  • WhatsApp"
echo "  • 1Password + CLI (avec agent SSH)"