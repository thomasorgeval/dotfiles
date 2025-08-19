# ----- PATH -----
export PATH="/opt/homebrew/bin:$PATH"

# ----- Starship Prompt -----
eval "$(starship init zsh)"

# ----- Autocompletion -----
autoload -Uz compinit && compinit

# ----- History -----
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
setopt sharehistory hist_ignore_all_dups hist_reduce_blanks

# ----- Plugins -----
# zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ----- zoxide (better cd) -----
eval "$(zoxide init zsh)"

# ----- Aliases -----
alias gs="git status"
alias gl="git log --oneline --graph --decorate"
alias gp="git push"
alias gpl="git pull"
alias ga="git add ."
alias gc="git commit -am"
alias k="kubectl"
alias d="docker"
