#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../lib/console.sh"

# ── Package Manager ───────────────────────────────────────────────────────────

center_text "CHECKING PACKAGE MANAGER"

if command -v apt-get &>/dev/null; then
  PKG_MANAGER="apt-get"
elif command -v dnf &>/dev/null; then
  PKG_MANAGER="dnf"
elif command -v pacman &>/dev/null; then
  PKG_MANAGER="pacman"
else
  error "No supported package manager found (apt-get, dnf, pacman)"
  exit 1
fi

success "Using package manager: $PKG_MANAGER"

# ── Helpers ───────────────────────────────────────────────────────────────────

install_package() {
  local package="$1"
  if dpkg -s "$package" &>/dev/null 2>&1 || rpm -q "$package" &>/dev/null 2>&1 || pacman -Q "$package" &>/dev/null 2>&1; then
    ok "Package '$package' is already installed"
  else
    log "Installing package '$package'..."
    case "$PKG_MANAGER" in
      apt-get) sudo apt-get install -y "$package" ;;
      dnf)     sudo dnf install -y "$package" ;;
      pacman)  sudo pacman -S --noconfirm "$package" ;;
    esac
    ok "Installed '$package'"
  fi
}

# ── Packages ──────────────────────────────────────────────────────────────────

DEPS_DIR="$(dirname "$0")/deps/linux"
source "$DEPS_DIR/packages.sh"

center_text "UPDATING PACKAGE INDEX"

case "$PKG_MANAGER" in
  apt-get) sudo apt-get update -y ;;
  dnf)     sudo dnf check-update -y || true ;;
  pacman)  sudo pacman -Sy ;;
esac

center_text "INSTALLING PACKAGES"

for package in "${PACKAGES[@]}"; do
  install_package "$package"
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
