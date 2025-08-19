# Mes dotfiles

Ce dépôt contient mes fichiers de configuration personnels (dotfiles) pour macOS et Linux (Debian/Ubuntu). Le script d'installation est conçu pour automatiser la mise en place de mon environnement de développement.

## Installation

Le script `install.sh` détecte automatiquement votre système d'exploitation (macOS ou Linux) et installe les logiciels et configurations appropriés.

1.  **Cloner le dépôt**
    ```bash
    git clone https://github.com/thomasorgeval/dotfiles.git ~/dotfiles
    cd ~/dotfiles
    ```

2.  **Lancer le script d'installation**
    Le script vous demandera votre mot de passe `sudo` pour installer les paquets système.
    ```bash
    chmod +x install.sh
    ./install.sh
    ```

### Systèmes d'exploitation supportés
*   **macOS**: Utilise [Homebrew](https://brew.sh/) pour l'installation des paquets.
*   **Linux**: Testé sur Debian/Ubuntu. Utilise `apt` et `snap`.

## Mise à jour
Pour mettre à jour les dotfiles et les paquets installés, il suffit de se placer dans le dossier et de ré-exécuter le script d'installation.

```bash
cd ~/dotfiles
git pull origin main
./install.sh
```

## Vérification
Après l'installation, redémarrez votre terminal et vérifiez que tout fonctionne :

```bash
# Vérifier la version de Starship
starship --version

# Vérifier la version de Zsh
zsh --version

# Vérifier la version de Node.js (installé via NVM)
node --version

# Vérifier la configuration de Git
git config --global --list
```