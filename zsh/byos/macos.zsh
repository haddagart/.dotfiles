# =========================
#   ~/.zshrc Configuration
# =========================

# --- ENVIRONMENT SETTINGS ---
export ZSH="$HOME/.oh-my-zsh"   # if using oh-my-zsh (optional)
export EDITOR="nvim"
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# --- STARSHIP PROMPT ---
# Make sure you have starship installed: https://starship.rs
eval "$(starship init zsh)"

# --- HISTORY SETTINGS ---
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_DUPS       # ignore duplicate commands
setopt HIST_FIND_NO_DUPS      # remove older duplicate when searching
setopt SHARE_HISTORY          # share history between shells

# --- ZSH OPTIONS ---
setopt AUTO_CD                # just type folder name to cd
setopt AUTO_PUSHD             # push old dir to stack on cd
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt CORRECT                # spell correction for commands
setopt NO_CASE_GLOB           # case-insensitive globbing

# --- ALIASES ---
alias ll="ls -lah"
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias v="nvim"
alias c="clear"

# --- PLUGINS (via zinit or antigen recommended) ---
# Example with zinit (fast plugin manager)
if [[ ! -f ~/.zinit/bin/zinit.zsh ]]; then
    mkdir -p ~/.zinit && git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
fi
source ~/.zinit/bin/zinit.zsh

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions

# --- COMPLETION SETTINGS ---
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# --- STARSHIP CONFIG (optional overrides) ---
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

# --- WELCOME MESSAGE ---
echo "🚀 Welcome back, $(whoami)! Enjoy your Zsh + Starship shell 🌌"