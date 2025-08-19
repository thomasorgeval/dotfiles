# ----- PATH -----
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# ----- Starship Prompt -----
eval "$(starship init zsh)"

# ----- Autocompletion -----
autoload -Uz compinit && compinit

# ----- History -----
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
setopt sharehistory hist_ignore_all_dups hist_reduce_blanks

# ----- NVM (Node Version Manager) -----
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# ----- Plugins -----
# zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ----- zoxide (better cd) -----
eval "$(zoxide init zsh)"

# ----- Aliases -----
# Navigation
alias ll="ls -la"
alias ..="cd .."
alias ...="cd ../.."
alias reload="source ~/.zshrc"

# Git
alias gs="git status"
alias gl="git log --oneline --graph --decorate"
alias gp="git push"
alias gpl="git pull"
alias ga="git add ."
alias gc="git commit -am"
alias gd="git diff"
alias gb="git branch"
alias gco="git checkout"

# Outils
alias k="kubectl"
alias d="docker"
