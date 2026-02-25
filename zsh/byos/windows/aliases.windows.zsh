# ================================
#  Windows/WSL-specific aliases
# ================================

# ── Tree view ─────────────────────────────────────────────────────────────────
if command -v eza &>/dev/null; then
  alias tree="eza --tree --icons --level=2"
elif command -v tree &>/dev/null; then
  alias tree="tree -L 2 --dirsfirst"
else
  alias tree="find . -maxdepth 2 | sed -e 's/[^-][^\/]*\//  |/g' -e 's/|\([^ ]\)/|-\1/'"
fi

# ── Dev directories ───────────────────────────────────────────────────────────
alias devdir="cd /mnt/c/Users/$USER/Developer"
alias devmac="cd ~/Developer/repos"

# ── Windows interop ───────────────────────────────────────────────────────────
alias open="explorer.exe"
alias pbp="powershell.exe -command 'Get-Clipboard'"
alias pbc="clip.exe"

# ── winget ────────────────────────────────────────────────────────────────────
alias wup="winget upgrade --all"
alias wi="winget install"
alias wr="winget uninstall"
alias ws="winget search"

# ── WSL utilities ─────────────────────────────────────────────────────────────
alias wsl-ip="ip route show | grep -i default | awk '{ print \$3 }'"
alias hosts="sudo nano /etc/hosts"
