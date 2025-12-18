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

# ----- 1Password SSH Agent -----
export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

# ----- NVM (Node Version Manager) -----
export NVM_DIR="$HOME/.nvm"
if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
  \. "/opt/homebrew/opt/nvm/nvm.sh" 2>/dev/null || echo "Warning: NVM initialization failed"
fi
if [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ]; then
  \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" 2>/dev/null
fi

# ----- Plugins -----
# Load zsh-autosuggestions with error handling
if [[ -r "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  # Set plugin variables before loading to avoid conflicts
  export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  export ZSH_AUTOSUGGEST_USE_ASYNC=1
  source "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" 2>/dev/null
fi

# Load zsh-syntax-highlighting last (Homebrew version)
if [[ -r "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# ----- zoxide (better cd) -----
eval "$(zoxide init zsh)"

# ----- Aliases -----
# Navigation
alias ll="ls -la"
alias ..="cd .."
alias ...="cd ../.."
alias doc="cd ~/Documents"
alias dl="cd ~/Downloads"
alias p="cd ~/projects"
alias reload="source ~/.zshrc"

# Git
alias g="git"
alias gs="git status"
alias gl="git log --oneline --graph --decorate"
alias gp="git push"
alias gpl="git pull"
alias ga="git add ."
alias gc="git commit -am"
alias gd="git diff"
alias gb="git branch"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gst="git stash"
alias gstp="git stash pop"
alias gcl="git clone"
alias gup='git checkout $(git symbolic-ref refs/remotes/origin/HEAD | sed "s@^refs/remotes/origin/@@") && git pull'

# Outils
alias k="kubectl"
alias d="docker"
alias pn="pnpm"
alias sb="pnpm supabase"
# Added by Antigravity
export PATH="/Users/thomas/.antigravity/antigravity/bin:$PATH"
