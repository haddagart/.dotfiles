# ================================
#  Linux-specific aliases
# ================================

# ── Dev directories ───────────────────────────────────────────────────────────
# Adjust path to match your Linux setup
alias devdir="cd /media/haddagart/Nitrodata/Developer/"
alias devmac="cd ~/Developer/repos"

# ── Package management ────────────────────────────────────────────────────────
if command -v apt-get &>/dev/null; then
  alias aup="sudo apt-get update && sudo apt-get upgrade -y"
  alias ai="sudo apt-get install -y"
  alias ar="sudo apt-get remove -y"
  alias acs="apt-cache search"
elif command -v dnf &>/dev/null; then
  alias aup="sudo dnf upgrade -y"
  alias ai="sudo dnf install -y"
  alias ar="sudo dnf remove -y"
  alias acs="dnf search"
elif command -v pacman &>/dev/null; then
  alias aup="sudo pacman -Syu"
  alias ai="sudo pacman -S"
  alias ar="sudo pacman -R"
  alias acs="pacman -Ss"
fi

# ── Clipboard ─────────────────────────────────────────────────────────────────
if command -v xclip &>/dev/null; then
  alias pbp="xclip -selection clipboard -o"
  alias pbc="xclip -selection clipboard"
elif command -v xsel &>/dev/null; then
  alias pbp="xsel --clipboard --output"
  alias pbc="xsel --clipboard --input"
fi

# ── Snap apps ─────────────────────────────────────────────────────────────────
if command -v snap &>/dev/null; then
  alias snap-telegram="snap run telegram-desktop"
  alias snap-notion="snap run notion-snap-reborn"
  alias snap-notesnook="snap run notesnook"
  alias snap-zotero="snap run zotero-snap"
  alias snap-spotify="snap run spotify"
fi

# ── System ────────────────────────────────────────────────────────────────────
alias open="xdg-open"
alias flushdns="sudo systemd-resolve --flush-caches 2>/dev/null || sudo resolvectl flush-caches 2>/dev/null"

# ── Printers ──────────────────────────────────────────────────────────────────
if command -v captstatusui &>/dev/null; then
  alias launch-printer="captstatusui -P LBP2900"
fi
