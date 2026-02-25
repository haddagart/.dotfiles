#!/usr/bin/env bash

set -e

DOTFILES="$(cd "$(dirname "$0")/.." && pwd -P)"

source "$DOTFILES/lib/console.sh"

# ── Helpers ───────────────────────────────────────────────────────────────────

# Detect if running on Windows (Git Bash / MSYS2 / Cygwin)
_is_windows() {
  case "$(uname -s)" in CYGWIN*|MINGW*|MSYS*) return 0 ;; esac
  return 1
}

link_file() {
  local src="$1" dst="$2"

  # Expand variables and ~
  src="${src/\$DOTFILES/$DOTFILES}"
  src="${src/\$HOME/$HOME}"
  src="${src/#\~/$HOME}"
  dst="${dst/\$DOTFILES/$DOTFILES}"
  dst="${dst/\$HOME/$HOME}"
  dst="${dst/#\~/$HOME}"

  if [ ! -e "$src" ]; then
    error "Source not found: $src"
    return
  fi

  # Already correctly linked
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    ok "Already linked: $dst → $src"
    return
  fi

  # Destination exists but is not our link
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    if [ "$overwrite_all" = "false" ] && [ "$backup_all" = "false" ] && [ "$skip_all" = "false" ]; then
      log "File already exists: $dst ($(basename "$src"))"
      printf "  [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all? "
      read -n 1 action </dev/tty
      echo
      case "$action" in
        o) overwrite=true ;;
        O) overwrite_all=true ;;
        b) backup=true ;;
        B) backup_all=true ;;
        s) skip=true ;;
        S) skip_all=true ;;
      esac
    fi

    local _overwrite="${overwrite:-$overwrite_all}"
    local _backup="${backup:-$backup_all}"
    local _skip="${skip:-$skip_all}"

    if [ "$_overwrite" = "true" ]; then
      rm -rf "$dst"
      success "Removed: $dst"
    elif [ "$_backup" = "true" ]; then
      mv "$dst" "${dst}.backup"
      success "Backed up: $dst → ${dst}.backup"
    elif [ "$_skip" = "true" ]; then
      ok "Skipped: $src"
      return
    fi
  fi

  # Ensure destination directory exists
  mkdir -p "$(dirname "$dst")"

  if _is_windows; then
    # On Windows use PowerShell to create a symlink (requires Developer Mode or admin)
    powershell.exe -Command "New-Item -ItemType SymbolicLink -Path '$dst' -Target '$src'" &>/dev/null \
      && success "Linked (Windows): $dst → $src" \
      || error "Failed to link (run as admin or enable Developer Mode): $dst"
  else
    ln -s "$src" "$dst"
    success "Linked: $dst → $src"
  fi
}

# ── Install dotfiles ──────────────────────────────────────────────────────────

install_dotfiles() {
  center_text "INSTALLING DOTFILES"

  local overwrite_all=false backup_all=false skip_all=false
  local overwrite= backup= skip=

  find -H "$DOTFILES" -maxdepth 2 -name 'links.prop' -not -path '*/.git/*' | while read -r linkfile; do
    while IFS='=' read -r src dst; do
      # Skip empty lines and comments
      [ -z "$src" ] && continue
      [[ "$src" =~ ^# ]] && continue

      # Trim whitespace
      src="${src#"${src%%[![:space:]]*}"}"
      src="${src%"${src##*[![:space:]]}"}"
      dst="${dst#"${dst%%[![:space:]]*}"}"
      dst="${dst%"${dst##*[![:space:]]}"}"

      # Make relative paths (no leading $) absolute from DOTFILES root
      if [[ "$src" != \$* && "$src" != \~* && "$src" != /* ]]; then
        src="$DOTFILES/$src"
      fi

      link_file "$src" "$dst"
    done < "$linkfile"
  done
}

install_dotfiles

center_text "BOOTSTRAPPING DONE"
