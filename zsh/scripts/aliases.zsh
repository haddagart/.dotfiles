# ================================
#  Aliases — universal loader
#  OS-specific aliases are in:
#    aliases.macos.zsh
#    aliases.linux.zsh
#    aliases.windows.zsh
# ================================

_ALIASES_DIR="$DOTFILES/zsh/scripts"

# ── Shell ──────────────────────────────────────────────────────────────────────
alias cls="clear"
alias zs="${EDITOR:-code} ~/.zshrc"
alias reload="source ~/.zshrc"

# ── Navigation ─────────────────────────────────────────────────────────────────
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# ── ls → eza ──────────────────────────────────────────────────────────────────
if command -v eza &>/dev/null; then
  alias ls="eza --icons"
  alias ll="eza -l --icons"
  alias la="eza -la --icons"
  alias lt="eza --tree --icons"
  alias lexa="eza -la --icons"
else
  alias ll="ls -lh"
  alias la="ls -lah"
fi

# ── cat → bat ─────────────────────────────────────────────────────────────────
if command -v bat &>/dev/null; then
  alias cat="bat --paging=never"
elif command -v batcat &>/dev/null; then
  alias cat="batcat --paging=never"
  alias bat="batcat"
fi

# ── Git ───────────────────────────────────────────────────────────────────────
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"
alias glog="git log --oneline --graph --decorate"

# ── Lazygit ───────────────────────────────────────────────────────────────────
if command -v lazygit &>/dev/null; then
  alias lg="lazygit"
elif [[ -x "$HOME/.local/bin/lazygit" ]]; then
  alias lg="$HOME/.local/bin/lazygit"
  alias lazygit="$HOME/.local/bin/lazygit"
fi

# ── Docker ────────────────────────────────────────────────────────────────────
alias dk="docker"
alias dkc="docker compose"

if command -v lazydocker &>/dev/null; then
  alias lzd="lazydocker"
elif [[ -x "$HOME/.local/bin/lazydocker" ]]; then
  alias lzd="sudo $HOME/.local/bin/lazydocker"
  alias lazydocker="sudo $HOME/.local/bin/lazydocker"
fi

# ── Python ────────────────────────────────────────────────────────────────────
alias py="python3"
alias pip="pip3"
alias venv="python3 -m venv"
alias activate="source .venv/bin/activate"

# ── Misc ──────────────────────────────────────────────────────────────────────
alias grep="grep --color=auto"
alias df="df -h"
alias du="du -sh"
alias ports="ss -tulnp 2>/dev/null || netstat -tulnp 2>/dev/null"

# ── Load OS-specific aliases ───────────────────────────────────────────────────
case "$(uname -s)" in
  Darwin)
    [[ -r "$_ALIASES_DIR/aliases.macos.zsh" ]] && source "$_ALIASES_DIR/aliases.macos.zsh"
    ;;
  Linux)
    # Detect WSL
    if grep -qi microsoft /proc/version 2>/dev/null; then
      [[ -r "$_ALIASES_DIR/aliases.windows.zsh" ]] && source "$_ALIASES_DIR/aliases.windows.zsh"
    fi
    [[ -r "$_ALIASES_DIR/aliases.linux.zsh" ]] && source "$_ALIASES_DIR/aliases.linux.zsh"
    ;;
esac

unset _ALIASES_DIR
