# ZSH global variables
export ZSH="$HOME/.oh-my-zsh"
export LANG=en_US.UTF-8
export DOTFILES=$HOME/.dotfiles

# ZSH Theme
ZSH_THEME="agnoster"

# ZSH plugins
plugins=(
    git
    starship
    virtualenv
    zsh-autosuggestions
    zsh-interactive-cd
    zsh-syntax-highlighting
    z
)

source $ZSH/oh-my-zsh.sh

# Preferred code editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='code'
fi

# Files existence verification function

source_if_exists() {
    if test -r "$1"; then
        source "$1"
    fi
}


# Import personalized sub-modules
source_if_exists $DOTFILES/zsh/aliases.zsh

# Import paths and auto-loaders
# source_if_exists $DOTFILES/zsh/conda.zsh
source_if_exists $DOTFILES/zsh/miniforge.zsh
source_if_exists $DOTFILES/zsh/nvim.zsh
source_if_exists $DOTFILES/zsh/pyenv.zsh
source_if_exists $DOTFILES/zsh/go.zsh

# Initiliaze starship
eval "$(starship init zsh)"
