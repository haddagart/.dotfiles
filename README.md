# Dotfiles

Personal development environment configuration for macOS, Linux, and Windows. Managed with symlinks via a lightweight bootstrap system.

---

## Table of Contents

- [Overview](#overview)
- [Quick Start](#quick-start)
- [Structure](#structure)
- [Installation](#installation)
  - [macOS](#macos)
  - [Linux](#linux)
  - [Windows](#windows)
- [What Gets Installed](#what-gets-installed)
- [Symlinks](#symlinks)
- [Configuration](#configuration)
  - [Zsh](#zsh)
  - [Starship](#starship)
  - [Tmux](#tmux)
  - [Neovim](#neovim)
  - [WezTerm](#wezterm)
  - [Vim](#vim)
- [Toolchain](#toolchain)

---

## Overview

```
~/.dotfiles/
├── install/              # Bootstrap and dependency installers
│   ├── init.sh           # Entry point — detects OS, installs deps, links dotfiles
│   ├── bootstap.sh       # Symlink manager (reads links.prop files)
│   ├── install-deps-macos.sh
│   ├── install-deps-linux.sh
│   ├── install-deps-win.ps1
│   ├── macos.sh          # macOS system preferences (optional, prompts before applying)
│   └── deps/             # Per-OS package lists
│       ├── macos/formulas.sh
│       ├── macos/casks.sh
│       ├── linux/packages.sh
│       └── windows/packages.ps1
├── lib/
│   ├── console.sh        # Shared logging helpers (bash)
│   └── console.ps1       # Shared logging helpers (PowerShell)
├── zsh/                  # Zsh config, plugins, and per-OS scripts
├── starship/             # Starship prompt config
├── tmux/                 # Tmux config + TPM plugins
├── nvim/                 # Neovim config (kickstart.nvim)
├── vim/                  # Vim config
├── terminals/wezterm/    # WezTerm config
├── neofetch/             # Neofetch config and themes
├── keychain/             # SSH key loading helper
├── vscode/               # VS Code CSS/JS customizations
└── links.prop            # Symlink definitions
```

---

## Quick Start

```sh
git clone --recurse-submodules https://github.com/haddagart/.dotfiles ~/.dotfiles
bash ~/.dotfiles/install/init.sh
```

This detects your OS and runs the full setup: package installation followed by dotfile symlinking.

---

## Structure

### `links.prop`

Defines which files to symlink and where. Format:

```
# relative/path/in/repo = ~/destination/path
zsh/.zshrc = ~/.zshrc
starship/starship.toml = ~/.config/starship.toml
```

Each directory can have its own `links.prop` (e.g. `neofetch/links.prop`). The bootstrap script discovers all of them automatically.

Current symlinks defined:

| Source | Destination |
|---|---|
| `zsh/.zshrc` | `~/.zshrc` |
| `vim/.vimrc` | `~/.vimrc` |
| `starship/starship.toml` | `~/.config/starship.toml` |
| `tmux/.tmux.conf` | `~/.tmux.conf` |
| `terminals/wezterm/.wezterm.lua` | `~/.wezterm.lua` |

### `install/`

| File | Purpose |
|---|---|
| `init.sh` | Entry point. Detects OS, dispatches to the right installer, then runs `bootstap.sh` |
| `bootstap.sh` | Reads all `links.prop` files and creates symlinks. Prompts on conflicts |
| `install-deps-macos.sh` | Installs Homebrew, formulas, casks, Oh My Zsh, Zap |
| `install-deps-linux.sh` | Installs system packages, Oh My Zsh, Zap |
| `install-deps-win.ps1` | Installs winget packages, Oh My Posh |
| `macos.sh` | Applies macOS system preferences via `defaults write` (optional — prompts before applying) |

---

## Installation

### macOS

```sh
bash ~/.dotfiles/install/init.sh
```

To apply macOS system preferences separately (optional, prompts for confirmation):

```sh
bash ~/.dotfiles/install/macos.sh
```

See [MAC_PREFERENCES.md](/docs/MAC_PREFERENCES.md) for a full reference of every setting applied.

Requires: macOS 15+ (Sequoia / Tahoe 26+). Tested on Apple Silicon (M1). Requires Xcode Command Line Tools (`xcode-select --install`).

### Linux

```sh
bash ~/.dotfiles/install/init.sh
```

Supports `apt-get`, `dnf`, and `pacman`. Run with a user that has `sudo` access.

### Windows

Run from **PowerShell as Administrator** (or with Developer Mode enabled for symlinks):

```powershell
git clone --recurse-submodules https://github.com/haddagart/.dotfiles $HOME/.dotfiles
pwsh -ExecutionPolicy Bypass -File $HOME/.dotfiles/install/install-deps-win.ps1
```

> **Note:** Symlink creation on Windows requires either Developer Mode (Settings → For Developers) or an elevated shell.

---

## What Gets Installed

### macOS (Homebrew)

**Formulas**

| Category | Tools |
|---|---|
| Shell & Terminal | `bat`, `eza`, `fzf`, `starship`, `tmux`, `zoxide`, `zsh`, `thefuck`, `tlrc`, `zzz` |
| File & Search | `fd`, `ripgrep`, `yazi`, `duf`, `sevenzip` |
| Git | `git`, `git-delta`, `lazygit` |
| Data & APIs | `jq`, `yq`, `xh` |
| System & Monitoring | `htop`, `btop`, `gping`, `wget`, `curl` |
| Dev Environment | `direnv`, `pyenv`, `uv`, `tokei`, `hyperfine`, `just` |
| Media & Documents | `ffmpeg`, `imagemagick`, `poppler`, `resvg` |
| Fonts & UI | `font-symbols-only-nerd-font` |
| Misc | `keychain`, `oh-my-posh`, `glow` |

**Casks (GUI apps)**

| Category | Apps |
|---|---|
| Terminal & Dev | `wezterm` |
| Editors & IDEs | `visual-studio-code` |
| Database | `dbeaver-community` |
| Version Control | `sourcetree` |
| Containers | `docker` |
| API & Network | `httpie` |
| Design | `figma` |
| Productivity | `notion`, `ticktick`, `obsidian` |
| File Management | `double-commander` |
| Fonts | `font-caskaydia-cove-nerd-font`, `font-jetbrains-mono-nerd-font` |
| Python / ML | `miniconda` |

### Linux (apt/dnf/pacman)

| Category | Tools |
|---|---|
| Shell & Terminal | `bat`, `eza`, `fzf`, `tmux`, `zsh`, `zoxide` |
| File & Search | `fd-find`, `ripgrep`, `duf`, `p7zip-full` |
| Git | `git`, `git-delta` |
| Data & APIs | `jq`, `yq`, `curl`, `wget` |
| System & Monitoring | `htop`, `btop` |
| Dev Environment | `direnv`, `pyenv`, `just`, `tokei` |
| Media & Documents | `ffmpeg`, `imagemagick`, `poppler-utils` |
| Fonts | `fonts-firacode`, `fonts-jetbrains-mono` |
| Misc | `keychain`, `xclip`, `xdotool` |

> Some tools are not in default repos on all distros and are installed separately:
> `lazygit`, `yazi`, `glow`, `xh`, `hyperfine` via Homebrew (Linuxbrew);
> `uv` via `curl -LsSf https://astral.sh/uv/install.sh | sh`;
> `starship` via `curl -sS https://starship.rs/install.sh | sh`

### Windows (winget)

| Category | Tools |
|---|---|
| Shell & Terminal | `Wez.WezTerm`, `Microsoft.WindowsTerminal`, `chrisant996.Clink`, `Starship.Starship` |
| File & Search | `sharkdp.bat`, `eza-community.eza`, `sharkdp.fd`, `Burntsushi.ripgrep.MSVC`, `junegunn.fzf`, `zoxide.zoxide`, `Clement.bottom`, `7zip.7zip` |
| Git | `Git.Git`, `dandavison.delta`, `JesseDuffield.lazygit` |
| Editors & IDEs | `Neovim.Neovim`, `Microsoft.VisualStudioCode` |
| Data & APIs | `jqlang.jq`, `mikefarah.yq`, `ducaale.xh` |
| Dev Environment | `Casey.Just`, `astral-sh.uv`, `pyenv-win.pyenv-win`, `direnv.direnv`, `XAMPPRocky.tokei`, `sharkdp.hyperfine` |
| Containers | `Docker.DockerDesktop`, `JesseDuffield.lazydocker` |
| Database | `dbeaver.dbeaver` |
| Design | `Figma.Figma` |
| Productivity | `Notion.Notion`, `TickTick.TickTick`, `Obsidian.Obsidian` |
| Media | `Gyan.FFmpeg`, `ImageMagick.ImageMagick` |
| Misc | `charmbracelet.glow`, `OliverSchwendener.unar` |

### All platforms

- **Oh My Zsh** — Zsh framework
- **Zap** — Lightweight Zsh plugin manager (macOS/Linux)
- **Oh My Posh** — Prompt theme engine (Windows)

---

## Symlinks

The bootstrap script handles conflicts interactively:

```
File already exists: ~/.zshrc (.zshrc), what do you want to do?
  [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?
```

Backup files are saved as `<original>.backup`.

To re-run symlinking only:

```sh
bash ~/.dotfiles/install/bootstap.sh
```

---

## Configuration

### Zsh

**Entry point:** `zsh/.zshrc`

- Uses [Starship](https://starship.rs) as the prompt
- Plugin management via [Zap](https://github.com/zap-zsh/zap) — plugin list in `zsh/plugins.txt`
- SSH keys auto-loaded via `keychain` (see `keychain/init.sh`)
- Editor: `vim` over SSH, `code` (VS Code) locally

**Plugins**

| Plugin | Purpose |
|---|---|
| `zsh-autosuggestions` | Fish-style inline suggestions |
| `zsh-syntax-highlighting` | Real-time syntax highlighting |
| `zsh-you-should-use` | Reminds you to use your aliases |
| `zsh-smartcache` | Caches slow completions for startup speed |
| `conda-zsh-completion` | Tab completions for conda |

**Scripts** (sourced automatically from `zsh/scripts/`):

| Script | Purpose |
|---|---|
| `aliases.zsh` | Universal aliases + OS-specific loader |
| `aliases.macos.zsh` | macOS-only aliases (sourced automatically on macOS) |
| `aliases.linux.zsh` | Linux-only aliases (sourced automatically on Linux) |
| `aliases.windows.zsh` | Windows/WSL aliases (sourced automatically in WSL) |
| `pyenv.zsh` | pyenv init |
| `nvm.zsh` | nvm init |
| `nvim.zsh` | Adds Neovim to PATH |
| `conda.zsh` | Conda init |

**Key aliases (universal)**

```sh
ls / ll / la / lt  → eza with icons (falls back to ls -l if eza not found)
cat                → bat --paging=never (falls back gracefully)
lg                 → lazygit
lzd                → lazydocker
cls                → clear
reload             → source ~/.zshrc
zs                 → open ~/.zshrc in $EDITOR
.. / ... / ....    → cd up 1 / 2 / 3 levels
g / gs / ga / gc   → git shortcuts
dk / dkc           → docker / docker compose
py / pip           → python3 / pip3
```

**macOS-specific aliases**

```sh
devmac             → cd ~/Developer/repos
bup                → brew update && upgrade && cleanup
flushdns           → flush macOS DNS cache
showfiles          → show hidden files in Finder
pbc / pbp          → pbcopy / pbpaste
```

**Linux-specific aliases**

```sh
devdir             → cd /media/.../Developer
aup / ai / ar      → apt/dnf/pacman update / install / remove
snap-*             → snap run <app>
open               → xdg-open
pbc / pbp          → xclip clipboard shortcuts
```

**Windows/WSL-specific aliases**

```sh
devdir             → cd /mnt/c/Users/$USER/Developer
open               → explorer.exe
pbc / pbp          → clip.exe / powershell Get-Clipboard
wup / wi / wr / ws → winget upgrade / install / uninstall / search
```

---

### Starship

**Config:** `starship/starship.toml`

Tokyo Night-inspired prompt with:

- **Left**: OS indicator → directory (3-level truncation with custom folder icons) → duration (shown if >60s)
- **Right**: sudo indicator → git branch → git commit hash → git status (ahead/behind counts) → Python version/venv

Directory icon substitutions: `Documents →`, `Downloads →`, `Codes → 󰅴`, `Data → 󰆼`, and more.

---

### Tmux

**Config:** `tmux/.tmux.conf`

- **Prefix:** `Ctrl+A` (screen-style)
- **True color:** `tmux-256color` + RGB overrides
- **Mouse:** enabled
- **Vi copy mode:** `v` to select, `y` to yank

**Key bindings**

| Key | Action |
|---|---|
| `prefix + \|` | Split pane horizontally |
| `prefix + -` | Split pane vertically |
| `prefix + r` | Reload config |
| `prefix + h/j/k/l` | Resize pane |
| `Ctrl+H/J/K/L` | Navigate panes (vim-tmux-navigator) |

**Plugins (via TPM)**

| Plugin | Purpose |
|---|---|
| `vim-tmux-navigator` | Seamless vim ↔ tmux pane navigation |
| `tmux-tokyo-night` | Tokyo Night status bar theme |
| `tmux-resurrect` | Save and restore sessions across reboots |
| `tmux-continuum` | Auto-save sessions every 15 minutes |

Install plugins after first launch: `prefix + I`

---

### Neovim

**Config:** `nvim/` (based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim))

- **Leader:** `Space`
- **Color scheme:** Tokyo Night
- **Plugin manager:** lazy.nvim (auto-installs on first run)

**Included plugins**

| Plugin | Purpose |
|---|---|
| `telescope.nvim` | Fuzzy finder |
| `nvim-lspconfig` + Mason | LSP with auto-install |
| `nvim-cmp` | Autocompletion |
| `nvim-treesitter` | Syntax highlighting |
| `lualine.nvim` | Status line |
| `gitsigns.nvim` | Git gutter signs |
| `which-key.nvim` | Keybinding hints |
| `neo-tree.nvim` | File tree (`\` to toggle) |
| `nvim-dap` | Debugger (Go pre-configured) |
| `nvim-autopairs` | Auto-close brackets and quotes |
| `nvim-lint` | Linting (`markdownlint` for Markdown) |

Custom plugins go in `nvim/lua/custom/plugins/init.lua`.

---

### WezTerm

**Config:** `terminals/wezterm/.wezterm.lua`

- **Font:** CaskaydiaCove Nerd Font Mono, 13pt (with JetBrains/FiraCode fallbacks)
- **Theme:** Catppuccin Mocha (dark) / Catppuccin Latte (light) — switches automatically with macOS appearance
- **Opacity:** 0.9 with macOS blur (intensity 20)
- **Tab bar:** bottom, fancy style, hidden when only one tab
- **Cursor:** Blinking underline

**Key bindings**

| Key | Action |
|---|---|
| `Ctrl+Shift+T` | New tab |
| `Ctrl+Shift+H/D` | Split horizontal / vertical |
| `Ctrl+Alt+H/J/K/L` | Navigate panes |
| `Ctrl+Shift+Arrow` | Resize pane |
| `Ctrl+Shift+F` | Search |
| `Ctrl+Shift+P` | Command palette |

---

### Vim

**Config:** `vim/.vimrc`

Minimal config for quick editing and remote sessions:

- Syntax highlighting
- Hybrid line numbers (absolute current + relative others)
- 4-space indentation (spaces, not tabs)
- Current line highlighting

---

## Toolchain

| Category | Tool |
|---|---|
| Shell | Zsh |
| Prompt | Starship |
| Plugin manager | Zap (macOS/Linux) / Oh My Posh (Windows) |
| Terminal | WezTerm |
| Editor | Neovim (kickstart) / VS Code |
| Multiplexer | tmux |
| File manager | yazi |
| Node | nvm |
| Python | pyenv + uv + conda/miniconda |
| HTTP client | xh / httpie |
| Git TUI | lazygit |
| Resource monitor | btop |
| SSH agent | keychain |
| Packages (macOS) | Homebrew |
| Packages (Linux) | apt / dnf / pacman + Homebrew |
| Packages (Windows) | winget |
| Fetch | neofetch |
