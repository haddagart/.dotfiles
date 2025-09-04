ZSH_THEME="agnoster"

export ZSH="$HOME/.oh-my-zsh"
export DOTFILES=$HOME/.dotfiles


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

# Import aliases before oh-my-zsh
source_if_exists $DOTFILES/zsh/aliases.zsh
source_if_exists $DOTFILES/zsh/conda.zsh
source_if_exists $DOTFILES/zsh/keychain.zsh
source_if_exists $DOTFILES/zsh/miniforge.zsh
source_if_exists $DOTFILES/zsh/nvim.zsh
source_if_exists $DOTFILES/zsh/nvm.zsh
source_if_exists $DOTFILES/zsh/pyenv.zsh

plugins=(
    git
    starship
    virtualenv
    you-should-use
    zsh-bat
    zsh-autosuggestions
    zsh-interactive-cd
    zsh-syntax-highlighting
    zsh-smartcache
    z
)

# Initialize oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Initiliaze starship
eval "$(starship init zsh)"
