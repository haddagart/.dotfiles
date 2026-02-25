# ================================
#  Environment
# ================================
export DOTFILES="$HOME/.dotfiles"

export EDITOR="${SSH_CONNECTION:+vim}"
export EDITOR="${EDITOR:-code}"

# ================================
#  Helper Functions
# ================================
source_if_exists() {
  [[ -r "$1" ]] && source "$1"
}

# ================================
#  Scripts
# ================================
ZSH_SCRIPTS=(
  aliases
  conda
  go
  miniforge
  nvim
  nvm
  pyenv
)

for _script in "${ZSH_SCRIPTS[@]}"; do
  source_if_exists "$DOTFILES/zsh/byos/$_script.zsh"
done
unset _script

# ================================
#  Completions
# ================================
# Docker Desktop completions (macOS)
[[ -d "$HOME/.docker/completions" ]] && fpath=("$HOME/.docker/completions" $fpath)

autoload -Uz compinit && compinit

# ================================
#  Plugins
# ================================
# Option A: zap (faster, lightweight)
source_if_exists "$HOME/.local/share/zap/zap.zsh"
if typeset -f plug &>/dev/null; then
  while IFS= read -r _plugin; do
    [[ -z "$_plugin" || "$_plugin" =~ ^# ]] && continue
    plug "$_plugin"
  done < "$DOTFILES/zsh/plugins.txt"
  unset _plugin
fi

# Option B: oh-my-zsh (uncomment and comment out zap above)
# plugins=(git virtualenv z)
# source "$HOME/.oh-my-zsh/oh-my-zsh.sh"

# ================================
#  SSH / Keychain
# ================================
source_if_exists "$DOTFILES/keychain/init.sh"

# ================================
#  Prompt
# ================================
# Option A: Starship
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# Option B: Powerlevel10k (uncomment and comment out starship above)
# source_if_exists "$HOME/.p10k.zsh"

# ================================
#  Tool PATH & Completions
# ================================
# Bun
export BUN_INSTALL="$HOME/.bun"
[[ -d "$BUN_INSTALL/bin" ]] && export PATH="$BUN_INSTALL/bin:$PATH"
source_if_exists "$BUN_INSTALL/_bun"

# Antigravity
[[ -d "$HOME/.antigravity/antigravity/bin" ]] && export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# Google Cloud SDK
source_if_exists "$HOME/Applications/google-cloud-sdk/path.zsh.inc"
source_if_exists "$HOME/Applications/google-cloud-sdk/completion.zsh.inc"

# ================================
#  API Keys
# ================================
# ⚠️  Move secrets to a gitignored file: $DOTFILES/zsh/byos/secrets.zsh
source_if_exists "$DOTFILES/zsh/byos/secrets.zsh"
