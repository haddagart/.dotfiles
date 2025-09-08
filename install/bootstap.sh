#!/usr/bin/env bash

# bootstrap installs things.

cd "$(dirname "$0")/.."
DOTFILES=$(pwd -P)

echo ''

info() {
  printf "\r  [ \033[00;34m..\033[0m ] %s\n" "$1"
}

user() {
  printf "\r  [ \033[0;33m??\033[0m ] %s\n" "$1"
}

success() {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"
}

fail() {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] %s\n" "$1"
}

link_file() {
  local src=$1 dst=$2
  local overwrite= backup= skip= action=

  # Expand ~
  eval src="$src"
  eval dst="$dst"

  # Verify source exists
  if [ ! -e "$src" ]; then
    fail "source not found: $src"
    return
  fi

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    local currentSrc
    currentSrc="$(readlink "$dst" 2>/dev/null)"

    if [ "$currentSrc" = "$src" ]; then
      success "already linked $dst → $src"
      return
    fi

    if [ "$overwrite_all" = "false" ] && [ "$backup_all" = "false" ] && [ "$skip_all" = "false" ]; then
      user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
      [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
      read -n 1 action </dev/tty
      echo

      case "$action" in
        o) overwrite=true ;;
        O) overwrite_all=true ;;
        b) backup=true ;;
        B) backup_all=true ;;
        s) skip=true ;;
        S) skip_all=true ;;
        *) ;;
      esac
    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" = "true" ]; then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" = "true" ]; then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" = "true" ]; then
      success "skipped $src"
      return
    fi
  fi

  ln -s "$src" "$dst"
  success "linked $dst → $src"
}

install_dotfiles() {
  info 'installing dotfiles'

  local overwrite_all=false backup_all=false skip_all=false

  find -H "$DOTFILES" -maxdepth 2 -name 'links.prop' -not -path '*.git*' | while read -r linkfile; do
    while IFS='=' read -r src dst; do
      # Skip empty lines and comments
      [ -z "$src" ] && continue
      [[ "$src" =~ ^# ]] && continue

      # Trim whitespace without echo/xargs
      src=${src#"${src%%[![:space:]]*}"}   # remove leading spaces
      src=${src%"${src##*[![:space:]]}"}   # remove trailing spaces
      dst=${dst#"${dst%%[![:space:]]*}"}   # remove leading spaces
      dst=${dst%"${dst##*[![:space:]]}"}   # remove trailing spaces

      # Make relative path absolute
      src="$DOTFILES/$src"

      link_file "$src" "$dst"
    done <"$linkfile"
  done
}

create_env_file() {
  if [ -f "$HOME/.env.sh" ]; then
    success "$HOME/.env.sh file already exists, skipping"
  else
    echo "export DOTFILES=$DOTFILES" >"$HOME/.env.sh"
    success 'created ~/.env.sh'
  fi
}

install_dotfiles
# create_env_file
success '🎉 All installed!'