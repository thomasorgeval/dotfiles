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
```

### 3. Cloner le dépôt et créer les liens symboliques
```bash
git clone git@github.com:thomasorgeval/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow .  # crée les liens symboliques
```