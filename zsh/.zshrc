export ZSH="$HOME/.oh-my-zsh"
export LANG=en_US.UTF-8
export DOTFILES=$HOME/.dotfiles

ZSH_THEME="agnoster"

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

# Preferred editor for local and remote sessions

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
# source_if_exists $DOTFILES/zsh/conda.zsh
source_if_exists $DOTFILES/zsh/miniforge.zsh

# Initiliaze starship
eval "$(starship init zsh)"
