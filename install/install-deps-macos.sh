#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../lib/console.sh"

# ── Homebrew ──────────────────────────────────────────────────────────────────

center_text "INSTALLING HOMEBREW"

if command -v brew &>/dev/null; then
  success "Homebrew is already installed: $(brew --version | head -n 1)"
else
  info "Homebrew is not installed. Installing now..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  _setup_brew_path() {
    local brew_bin="$1"
    eval "$("$brew_bin" shellenv)"
    echo "eval \"\$(${brew_bin} shellenv)\"" >> ~/.zprofile
  }

  if [[ -x "/opt/homebrew/bin/brew" ]]; then
    _setup_brew_path "/opt/homebrew/bin/brew"
  elif [[ -x "/usr/local/bin/brew" ]]; then
    _setup_brew_path "/usr/local/bin/brew"
  fi

  success "Homebrew installation completed: $(brew --version | head -n 1)"
fi

export HOMEBREW_NO_ENV_HINTS=1

# ── Helpers ───────────────────────────────────────────────────────────────────

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

# ── Packages ──────────────────────────────────────────────────────────────────

DEPS_DIR="$(dirname "$0")/deps/macos"
source "$DEPS_DIR/formulas.sh"
source "$DEPS_DIR/casks.sh"

center_text "INSTALLING HOMEBREW FORMULAS"

for formula in "${FORMULAS[@]}"; do
  install_formula "$formula"
done

center_text "INSTALLING HOMEBREW CASKS"

for cask in "${CASKS[@]}"; do
  install_cask "$cask"
done

# ── Oh My Zsh ─────────────────────────────────────────────────────────────────

center_text "INSTALLING OH-MY-ZSH"

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  info "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  success "Oh My Zsh installed"
else
  log "Oh My Zsh is already installed"
fi

# ── Zap ───────────────────────────────────────────────────────────────────────

center_text "INSTALLING ZAP (ZSH PLUGIN MANAGER)"

ZAP_DIR="$HOME/.local/share/zap"
if [[ ! -d "$ZAP_DIR" ]]; then
  git clone --depth=1 https://github.com/zap-zsh/zap.git "$ZAP_DIR"
  success "Zap installed"
else
  log "Zap is already installed"
fi

source "$ZAP_DIR/zap.zsh"

# ─────────────────────────────────────────────────────────────────────────────

center_text "BOOTSTRAPPING DONE"
