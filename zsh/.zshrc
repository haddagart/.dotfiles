# ================================
#  Paths & Environment
# ================================
export DOTFILES="$HOME/.dotfiles"
export OZSH="$HOME/.oh-my-zsh"

# Preferred editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='code'
fi

# ================================
#  Helper Functions
# ================================
source_if_exists() {
  [[ -r "$1" ]] && source "$1"
}

# ================================
#  Custom Scripts
# ================================
ZSH_SUBSCRIPTS=(
  aliases
  conda
  keychain
  nvim
  nvm
  pyenv
)

for script in "${ZSH_SUBSCRIPTS[@]}"; do
  source_if_exists "$DOTFILES/zsh/scripts/$script.zsh"
done

# ================================
#  Plugins
# ================================
# -- Option A: using zap (faster, lightweight)
source ~/.local/share/zap/zap.zsh
while IFS= read -r plugin; do
  [[ -z "$plugin" || "$plugin" =~ ^# ]] && continue
  plug "$plugin"
done < "$DOTFILES/zsh/plugins.txt"

# -- Option B: using oh-my-zsh (comment out zap if you prefer this)
# plugins=(git virtualenv z)
# source $OZSH/oh-my-zsh.sh

# ================================
#  Keychain
# ================================
# Load keychain only once (via init.sh)
if command -v keychain >/dev/null 2>&1; then
  if [[ -z "$SSH_AUTH_SOCK" || ! -S "$SSH_AUTH_SOCK" ]]; then
    [[ -f "$HOME/.dotfiles/keychain/init.sh" ]] && source "$HOME/.dotfiles/keychain/init.sh"
  fi
fi

# ================================
#  Prompt
# ================================
# Powerlevel10k (⚠️ disable if using starship)
# [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Starship (⚠️ disable if using p10k)
eval "$(starship init zsh)"