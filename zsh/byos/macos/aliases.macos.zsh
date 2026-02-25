# ================================
#  macOS-specific aliases
# ================================

# ── Tree view ─────────────────────────────────────────────────────────────────
if command -v eza &>/dev/null; then
  alias tree="eza --tree --icons --level=2"
else
  alias tree="find . -maxdepth 2 | sed -e 's/[^-][^\/]*\//  |/g' -e 's/|\([^ ]\)/|-\1/'"
fi

# ── Dev directories ───────────────────────────────────────────────────────────
alias devmac="cd ~/Developer/repos"
alias devdir="cd ~/Developer"

# ── macOS utilities ───────────────────────────────────────────────────────────
alias flushdns="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES && killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO && killall Finder"
alias cleanup="find . -name '.DS_Store' -delete"
alias openapp="open -a"

# ── Clipboard ─────────────────────────────────────────────────────────────────
alias pbp="pbpaste"
alias pbc="pbcopy"

# ── Homebrew ──────────────────────────────────────────────────────────────────
alias bup="brew update && brew upgrade && brew cleanup"
alias bls="brew list"
alias bsr="brew search"

# ── Google Cloud SDK ──────────────────────────────────────────────────────────
if [[ -x "$HOME/Developer/google-cloud-sdk/bin/gcloud" ]]; then
  alias gcloud="$HOME/Developer/google-cloud-sdk/bin/gcloud"
fi
