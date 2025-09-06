#!/usr/bin/env bash

source "$(dirname "$0")/../lib/console.sh"

# set -e

center_text "INSTALLING HOMBREW"

# Check if brew exists
if command -v brew &> /dev/null; then
  success "Homebrew is already installed: $(brew --version | head -n 1)"
else
  info "Homebrew is not installed. Installing now..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add Homebrew to PATH if not already
  if [[ -d "/opt/homebrew/bin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  elif [[ -d "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
    echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
  fi

  success "Homebrew installation completed."
  brew --version
fi

export HOMEBREW_NO_ENV_HINTS=1

# Function: install a Homebrew formula if not installed
install_formula() {
  local formula="$1"
  if brew list --formula "$formula" &>/dev/null; then
    ok "Formula '$formula' is already installed"
  else
    log "Installing formula '$formula'..."
    brew install "$formula"
    ok "Installed '$formula'"
  fi
}

# Function: install a Homebrew cask if not installed
install_cask() {
  local cask="$1"
  if brew list --cask "$cask" &>/dev/null; then
    ok "Cask '$cask' is already installed"
  else
    log "Installing cask '$cask'..."
    brew install --cask "$cask"
    ok "Installed '$cask'"
  fi
}

FORMULAS=(
  bat\
  curl\
  duf\
  eza\
  fd\
  ffmpeg\
  font-symbols-only-nerd-font\
  fzf\
  git-delta\
  git\
  htop\
  imagemagick\
  jq\
  keychain\
  oh-my-posh\
  poppler\
  pyenv\
  resvg\
  ripgrep\
  sevenzip\
  sourcetree\
  starship\
  thefuck\
  tlrc\
  uv\
  wget\
  yazi\
  zoxide\
  zsh\
  zzz\
)

CASKS=(
  dbeaver-community\
  double-commander\
  miniconda\
  notion\
  ticktick\
)

center_text "INSTALLING HOMEBREW FORMULAS"

for formula in "${FORMULAS[@]}"; do
  install_formula "$formula"
done


center_text "INSTALLING HOMEBREW CASKS"

for cask in "${CASKS[@]}"; do
  install_cask "$cask"
done

log "Please make sure to register the flags properly"

center_text "INSTALLING OH-MY-ZSH"

# Installing Oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  echo "Oh-my-zsh is installed"
else
  log "Oh-my-zsh is already installed"
fi

center_text "INSTALLING ZAP (OH-MY-ZSH PLUGINS MANAGER)"

ZAP_DIR="$HOME/.local/share/zap"
if [[ ! -d $ZAP_DIR ]]; then
  git clone --depth=1 https://github.com/zap-zsh/zap.git "$ZAP_DIR"
else
  log "Zap is already installed"
fi

source "$ZAP_DIR/zap.zsh"

center_text "🎉 BOOTSTRAPPING DONE"