# Windows packages — installed via winget
# Covers: developer, AI researcher, fullstack, DevOps, designer workflow

$PACKAGES = @(
    # ── Shell & Terminal ──────────────────────────────────────────────────────
    "Wez.WezTerm"                      # GPU-accelerated terminal (primary)
    "Microsoft.WindowsTerminal"        # fallback terminal
    "chrisant996.Clink"                # bash-like line editing for cmd.exe
    "Starship.Starship"                # cross-shell prompt

    # ── File & Search ─────────────────────────────────────────────────────────
    "sharkdp.bat"                      # cat with syntax highlighting
    "eza-community.eza"                # modern ls
    "sharkdp.fd"                       # fast find
    "Burntsushi.ripgrep.MSVC"          # fast grep (rg)
    "junegunn.fzf"                     # fuzzy finder
    "zoxide.zoxide"                    # smarter cd
    "Clement.bottom"                   # resource monitor (btop alternative)
    "7zip.7zip"                        # archive tool

    # ── Git ───────────────────────────────────────────────────────────────────
    "Git.Git"                          # version control
    "dandavison.delta"                 # syntax-highlighted git diffs
    "JesseDuffield.lazygit"            # terminal UI for git

    # ── Editors & IDEs ────────────────────────────────────────────────────────
    "Neovim.Neovim"                    # terminal editor
    "Microsoft.VisualStudioCode"       # code editor

    # ── Data & APIs ───────────────────────────────────────────────────────────
    "jqlang.jq"                        # JSON processor
    "mikefarah.yq"                     # YAML/JSON/TOML processor
    "ducaale.xh"                       # fast HTTP client

    # ── Dev Environment ───────────────────────────────────────────────────────
    "Casey.Just"                       # command runner (Makefile alternative)
    "astral-sh.uv"                     # fast Python package manager
    "pyenv-win.pyenv-win"              # Python version manager
    "direnv.direnv"                    # per-project env vars
    "XAMPPRocky.tokei"                 # count lines of code by language
    "sharkdp.hyperfine"                # command benchmarking

    # ── Containers & DevOps ───────────────────────────────────────────────────
    "Docker.DockerDesktop"             # container runtime
    "JesseDuffield.lazydocker"         # Docker TUI

    # ── Database ──────────────────────────────────────────────────────────────
    "dbeaver.dbeaver"                  # universal database GUI

    # ── Design ────────────────────────────────────────────────────────────────
    "Figma.Figma"                      # UI/UX design

    # ── Productivity ──────────────────────────────────────────────────────────
    "Notion.Notion"                    # notes and knowledge base
    "TickTick.TickTick"                # task manager
    "Obsidian.Obsidian"                # local markdown knowledge vault

    # ── Media & Documents ─────────────────────────────────────────────────────
    "Gyan.FFmpeg"                      # video/audio processing
    "ImageMagick.ImageMagick"          # image manipulation

    # ── Misc ──────────────────────────────────────────────────────────────────
    "charmbracelet.glow"               # render Markdown in terminal
    "OliverSchwendener.unar"           # universal archive extractor
)
