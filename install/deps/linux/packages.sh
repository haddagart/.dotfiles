#!/usr/bin/env bash

# apt/dnf/pacman package names
# Note: some tools (lazygit, yazi, btop, glow, xh, tokei, hyperfine, direnv)
# are not in default repos on all distros — installed via Homebrew (Linuxbrew)
# or downloaded directly where noted.

PACKAGES=(
  # ── Shell & Terminal ──────────────────────────────────────────────────────
  bat           # cat with syntax highlighting (may be 'batcat' on Ubuntu)
  eza           # modern ls (may need manual install on older distros)
  fzf           # fuzzy finder
  tmux          # terminal multiplexer
  zsh           # shell
  zoxide        # smarter cd

  # ── File & Search ─────────────────────────────────────────────────────────
  fd-find       # fast find (binary is 'fdd' on Debian/Ubuntu; alias to fd)
  ripgrep       # fast grep (rg)
  duf           # disk usage overview
  p7zip-full    # 7-zip archive tool

  # ── Git ───────────────────────────────────────────────────────────────────
  git           # version control
  git-delta     # syntax-highlighted git diffs

  # ── Data & APIs ───────────────────────────────────────────────────────────
  jq            # JSON processor
  yq            # YAML/JSON/TOML processor
  curl          # HTTP transfers
  wget          # file downloader

  # ── System & Monitoring ───────────────────────────────────────────────────
  htop          # process viewer
  btop          # beautiful resource monitor

  # ── Dev Environment ───────────────────────────────────────────────────────
  direnv        # per-project .envrc — auto-loads env vars
  pyenv         # Python version manager (via pyenv installer)
  just          # command runner (Makefile alternative)
  tokei         # count lines of code by language

  # ── Media & Documents ─────────────────────────────────────────────────────
  ffmpeg        # video/audio processing
  imagemagick   # image manipulation
  poppler-utils # PDF utilities (pdftotext, pdftoppm etc.)

  # ── Fonts ─────────────────────────────────────────────────────────────────
  fonts-firacode         # fallback monospace font
  fonts-jetbrains-mono   # JetBrains Mono (fallback)

  # ── Misc ──────────────────────────────────────────────────────────────────
  keychain      # SSH agent manager
  xclip         # clipboard access from terminal
  xdotool       # keyboard/mouse automation
)

# ── Installed separately (not in standard repos) ──────────────────────────────
# These are installed via their own installers or Homebrew on Linux:
#
#   lazygit   → brew install lazygit
#   yazi      → brew install yazi
#   glow      → brew install glow
#   xh        → brew install xh
#   hyperfine → brew install hyperfine
#   uv        → curl -LsSf https://astral.sh/uv/install.sh | sh
#   starship  → curl -sS https://starship.rs/install.sh | sh
