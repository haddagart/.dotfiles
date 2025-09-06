#!/usr/bin/env bash

# This is temporary, it may change to links and other specialized scripts 
# In best cases it will be further tuned using charm CLI to transform it into an installation wizard

# Detect OS
case "$(uname -s)" in
  Darwin)   export OS="macos" ;;
  Linux)    export OS="linux" ;;
  CYGWIN*|MINGW*|MSYS*) export OS="windows" ;;
  *)        export OS="unknown" ;;
esac

# Define standard paths in dotfiles
export DF=$HOME/.dotfiles
export DF_ZSH=$DF/zsh
export DF_NEOFETCH=$DF/neofetch
export DF_STARSHIP=$DF/starship

# Define standard paths in the operating system
export OS_NEOFETCH=$HOME/.config/neofetch
export OS_ZSH=$HOME
export OS_STARSHIP=$HOME/.config/

# Oh-my-zsh
echo ">>> Setting up zshrc"
ln -sf $DF_ZSH/.zshrc $OS_ZSH/.zshrc

# Starship
if [ -d $DF_STARSHIP ]; then
    echo ">>> Setting up starship"
    if [ -f $OS_STARSHIP/starship.toml ]; then
        echo "  - Making a backup of the current starship config"
        echo "  * Backup can be found in: "$DF_STARSHIP/backup/
        cp $OS_STARSHIP/starship.toml $DF_STARSHIP/backup/starship.backup.toml

        echo "  - Liking Pillship theme by Abdelkader Haddag to config"
        ln -sf $DF_STARSHIP/starship.toml $OS_STARSHIP/starship.toml
    fi
fi

# Neofetch
if [ -d $OS_NEOFETCH ]; then
    echo ">>> Setting up neofetch"
    if [ -f $OS_NEOFETCH/config.conf ]; then
        echo "  - Making a backup of the current neofetch config"
        echo "  * Backup can be found in: "$DF_NEOFETCH/backup/
        cp $OS_NEOFETCH/config.conf $DF_NEOFETCH/backup/config.backup.conf

        echo "  - Copying Acenoster theme by Senpai Legend to config"
        cp $DF_NEOFETCH/themes/normal/acenoster.conf $OS_NEOFETCH/config.conf
    fi
fi
