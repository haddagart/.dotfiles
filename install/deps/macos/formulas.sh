#!/usr/bin/env bash

FORMULAS=(
  # ── Shell & Terminal ──────────────────────────────────────────────────────
  bat           # cat with syntax highlighting
  eza           # modern ls with icons and git status
  fzf           # fuzzy finder — used across shell, vim, git
  starship      # cross-shell prompt
  tmux          # terminal multiplexer
  zoxide        # smarter cd (learns your frecency)
  zsh           # shell
  thefuck       # corrects mistyped commands
  tlrc          # tldr client — community cheatsheets
  zzz           # sleep utility

  # ── File & Search ─────────────────────────────────────────────────────────
  fd            # fast find alternative
  ripgrep       # fast grep (rg) — used in vim/neovim
  yazi          # terminal file manager with preview
  duf           # disk usage overview (nicer than df)
  sevenzip      # archive tool (7z)

  # ── Git ───────────────────────────────────────────────────────────────────
  git           # version control
  git-delta     # syntax-highlighted git diffs
  lazygit       # terminal UI for git

  # ── Data & APIs ───────────────────────────────────────────────────────────
  jq            # JSON processor
  yq            # YAML/JSON/TOML processor (pairs with jq)
  xh            # fast HTTP client (curl alternative for APIs)

  # ── System & Monitoring ───────────────────────────────────────────────────
  htop          # process viewer
  btop          # beautiful resource monitor (CPU/mem/net/disk)
  gping         # visual ping with graph
  wget          # file downloader
  curl          # HTTP transfers

  # ── Dev Environment ───────────────────────────────────────────────────────
  direnv        # per-project .envrc — auto-loads env vars
  pyenv         # Python version manager
  uv            # fast Python package manager (replaces pip/venv)
  tokei         # count lines of code by language
  hyperfine     # command-line benchmarking tool
  just          # modern command runner (Makefile alternative)

  # ── Media & Documents ─────────────────────────────────────────────────────
  ffmpeg        # video/audio processing
  imagemagick   # image manipulation
  poppler       # PDF utilities (pdftotext, pdftoppm etc.)
  resvg         # SVG renderer

  # ── Fonts & UI ────────────────────────────────────────────────────────────
  font-symbols-only-nerd-font  # Nerd Font symbols (icons in terminal)

  # ── Misc ──────────────────────────────────────────────────────────────────
  keychain      # SSH agent manager
  oh-my-posh    # prompt theme engine
  glow          # render Markdown in terminal
)
