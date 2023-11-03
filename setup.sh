# Set the global path of the dotfiles
export DOTFILES=~/.dotfiles
# ZSH
ln -sf $DOTFILES/zsh/.zshrc $HOME/.zshrc
# Starship
ln -sf $DOTFILES/starship/starship.toml $HOME/.config/starship.toml