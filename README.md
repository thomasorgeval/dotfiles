# Mes dotfiles

Contient les fichiers de configuration pour mon environnement de développement.

## Installation

### 1. Installer Homebrew
Homebrew est le gestionnaire de paquets de macOS.  
Exécute cette commande dans ton terminal :

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Installer les paquets nécessaires
```bash
brew install stow git 

# Prompt moderne
brew install starship

# Navigation améliorée
brew install zoxide

# Plugins zsh
brew install zsh-autosuggestions zsh-syntax-highlighting

# Outils de développement (optionnel)
brew install kubectl docker
```

### 3. Cloner le dépôt et créer les liens symboliques
```bash
# Cloner le dépôt
git clone git@github.com:thomasorgeval/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

## Mise à jour
Si tu souhaites mettre à jour tes dotfiles, exécute les commandes suivantes :

```bash
cd ~/dotfiles
git pull origin main
stow .  # Re-créer les liens si nécessaire
chmod 700 ~/.ssh
chmod 600 ~/.ssh/config
source ~/.zshrc # Recharger la configuration de Zsh
```

## Vérification
Pour vérifier que tout fonctionne correctement, tu peux exécuter les commandes suivantes :

```bash
# Vérifier la version de Starship
starship --version
# Vérifier la version de Zsh
zsh --version
# Vérifier la config de Git
which git
git --version
git config --global --list
```