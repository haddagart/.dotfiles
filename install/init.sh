#!/usr/bin/env bash

set -e

DOTFILES="$(cd "$(dirname "$0")/.." && pwd -P)"
INSTALL_DIR="$DOTFILES/install"

source "$DOTFILES/lib/console.sh"

# ── OS Detection ──────────────────────────────────────────────────────────────

center_text "DETECTING OPERATING SYSTEM"

case "$(uname -s)" in
  Darwin)              OS="macos" ;;
  Linux)               OS="linux" ;;
  CYGWIN*|MINGW*|MSYS*) OS="windows" ;;
  *)
    error "Unsupported OS: $(uname -s)"
    exit 1
    ;;
esac

export OS
export DOTFILES

success "Detected OS: $OS"

# ── Install Dependencies ──────────────────────────────────────────────────────

center_text "INSTALLING DEPENDENCIES"

case "$OS" in
  macos)
    bash "$INSTALL_DIR/install-deps-macos.sh"
    ;;
  linux)
    bash "$INSTALL_DIR/install-deps-linux.sh"
    ;;
  windows)
    if command -v pwsh &>/dev/null; then
      pwsh -ExecutionPolicy Bypass -File "$INSTALL_DIR/install-deps-win.ps1"
    elif command -v powershell.exe &>/dev/null; then
      powershell.exe -ExecutionPolicy Bypass -File "$INSTALL_DIR/install-deps-win.ps1"
    else
      error "PowerShell not found. Cannot install Windows dependencies."
      exit 1
    fi
    ;;
esac

# ── Symlink Dotfiles ──────────────────────────────────────────────────────────

bash "$INSTALL_DIR/bootstap.sh"

# ─────────────────────────────────────────────────────────────────────────────

center_text "INIT COMPLETE"
