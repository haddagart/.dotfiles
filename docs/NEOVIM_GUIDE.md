# Neovim Guide

> A practical reference for someone coming from VSCode/Atom who wants to learn Vim properly.
> The goal is not to replicate VSCode — it's to learn the Vim way, which is faster once it clicks.

---

## Table of Contents

- [Philosophy](#philosophy)
- [Modes](#modes)
- [Your Custom Keymaps](#your-custom-keymaps)
- [Essential Vim Motions](#essential-vim-motions)
- [Editing Verbs + Nouns](#editing-verbs--nouns)
- [Search and Replace](#search-and-replace)
- [Splits and Buffers](#splits-and-buffers)
- [Installed Plugins](#installed-plugins)
- [Plugin Manager (lazy.nvim)](#plugin-manager-lazynvim)
- [Adding Plugins](#adding-plugins)
- [Tips for VSCode Refugees](#tips-for-vscode-refugees)
- [Learning Path](#learning-path)

---

## Philosophy

In Vim, you **compose** commands from small building blocks. Instead of memorizing hundreds of shortcuts, you learn ~20 primitives and combine them:

```
[count] [verb] [noun]
  2       d      w     →  delete 2 words
  3       y      j     →  yank 3 lines down
  c       i      "     →  change inside quotes
```

Once this clicks, editing feels like speaking a language — not pressing shortcuts.

---

## Modes

| Mode | How to Enter | What it Does |
|------|-------------|--------------|
| **Normal** | `Esc` or `jk` | Navigate and issue commands. This is your home. |
| **Insert** | `i` `a` `o` | Type text like a regular editor |
| **Visual** | `v` | Select characters |
| **Visual Line** | `V` | Select whole lines |
| **Visual Block** | `Ctrl+v` | Select a column of text |
| **Command** | `:` | Run ex commands (`:w`, `:q`, etc.) |

> **Key habit to build:** Return to Normal mode constantly. Normal mode is where you think; Insert mode is only for typing.

---

## Your Custom Keymaps

> Leader key is `Space`.

### Essentials

| Key | Mode | Action |
|-----|------|--------|
| `jk` | Insert | Exit to Normal mode |
| `Space w` | Normal | Save file |
| `Space q` | Normal | Close window |
| `Space Q` | Normal | Quit all |
| `Space /` | Normal | Clear search highlight |

### File Explorer (nvim-tree)

| Key | Action |
|-----|--------|
| `Space ee` | Toggle file explorer |
| `Space ef` | Toggle explorer and focus current file |
| `Space ec` | Collapse all folders |
| `Space er` | Refresh explorer |

### Window Splits (like VSCode split editor)

| Key | Action |
|-----|--------|
| `Space sv` | Split vertically |
| `Space sh` | Split horizontally |
| `Space se` | Equalize split sizes |
| `Space sx` | Close current split |
| `Space sm` | Maximize / restore current split |
| `Ctrl+h/j/k/l` | Navigate between splits (also works across tmux panes) |

### Buffers (like VSCode tabs)

| Key | Action |
|-----|--------|
| `Tab` | Next buffer |
| `Shift+Tab` | Previous buffer |
| `Space bd` | Close current buffer |

### Line Movement (like Alt+Up/Down in VSCode)

| Key | Mode | Action |
|-----|------|--------|
| `Alt+j` | Normal/Visual | Move line/selection down |
| `Alt+k` | Normal/Visual | Move line/selection up |

### Indenting

| Key | Mode | Action |
|-----|------|--------|
| `>` | Visual | Indent right (keeps selection) |
| `<` | Visual | Indent left (keeps selection) |

### Autocompletion (nvim-cmp — active in Insert mode)

| Key | Action |
|-----|--------|
| `Ctrl+k` | Select previous suggestion |
| `Ctrl+j` | Select next suggestion |
| `Ctrl+Space` | Trigger completion manually |
| `Ctrl+e` | Close completion menu |
| `Enter` | Confirm selected suggestion |
| `Ctrl+b / Ctrl+f` | Scroll docs up / down |

### Commenting (Comment.nvim)

| Key | Mode | Action |
|-----|------|--------|
| `gcc` | Normal | Toggle comment on current line |
| `gc` | Visual | Toggle comment on selection |
| `gbc` | Normal | Toggle block comment |

### Other

| Key | Action |
|-----|--------|
| `x` | Delete character without yanking |
| `Space p` | Paste without overwriting clipboard (Visual) |
| `Space +` | Increment number under cursor |
| `Space -` | Decrement number under cursor |

---

## Essential Vim Motions

### Movement

| Key | Action |
|-----|--------|
| `h j k l` | Left / Down / Up / Right |
| `w` | Jump to start of next word |
| `b` | Jump to start of previous word |
| `e` | Jump to end of word |
| `0` | Start of line |
| `^` | First non-blank character of line |
| `$` | End of line |
| `gg` | Top of file |
| `G` | Bottom of file |
| `{` / `}` | Jump paragraph up / down |
| `Ctrl+d` | Scroll half page down |
| `Ctrl+u` | Scroll half page up |
| `zz` | Center cursor on screen |
| `%` | Jump to matching bracket |
| `f{char}` | Jump to next occurrence of char on line |
| `t{char}` | Jump to just before next char on line |

### Enter Insert Mode

| Key | Action |
|-----|--------|
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `I` | Insert at start of line |
| `A` | Insert at end of line |
| `o` | New line below and insert |
| `O` | New line above and insert |

---

## Editing Verbs + Nouns

### Verbs

| Key | Action |
|-----|--------|
| `d` | Delete (cut) |
| `y` | Yank (copy) |
| `c` | Change (delete + enter insert) |
| `v` | Visually select |
| `>` / `<` | Indent / dedent |

### Nouns (text objects)

| Key | Meaning |
|-----|---------|
| `w` | Word |
| `l` | Character (letter) |
| `j` / `k` | Line down / up |
| `$` | To end of line |
| `0` | To start of line |
| `i"` | Inside double quotes |
| `a"` | Around double quotes (includes quotes) |
| `i(` | Inside parentheses |
| `i{` | Inside curly braces |
| `ip` | Inside paragraph |
| `it` | Inside HTML/XML tag |

### Examples

| Command | Result |
|---------|--------|
| `diw` | Delete inner word |
| `ci"` | Change text inside quotes |
| `ya(` | Yank everything including parentheses |
| `v3j` | Visually select 3 lines down |
| `d$` | Delete to end of line |
| `yy` | Yank current line |
| `dd` | Delete current line |
| `cc` | Change entire line |

---

## Search and Replace

| Command | Action |
|---------|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` / `N` | Next / previous match (centered) |
| `*` | Search for word under cursor |
| `Space /` | Clear search highlight |
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Replace all with confirmation |
| `:s/old/new/g` | Replace all in current line |

---

## Splits and Buffers

**Splits** = visible panes on screen
**Buffers** = open files (may not all be visible)

| Command | Action |
|---------|--------|
| `Space sv` | Split vertically |
| `Space sh` | Split horizontally |
| `Ctrl+h/j/k/l` | Move between splits |
| `Space se` | Equalize sizes |
| `Space sx` | Close split |
| `Space sm` | Maximize / restore split |
| `Tab` / `Shift+Tab` | Cycle buffers |
| `Space bd` | Close buffer |
| `:e filename` | Open file in current buffer |
| `:ls` | List all open buffers |

---

## Installed Plugins

| Plugin | Purpose |
|--------|---------|
| `catppuccin/nvim` | Colorscheme — Latte (light) / Mocha (dark), auto-detected from macOS appearance |
| `christoomey/vim-tmux-navigator` | Seamless navigation between nvim splits and tmux panes with `Ctrl+h/j/k/l` |
| `nvim-tree/nvim-tree.lua` | File explorer sidebar (VSCode-style) |
| `szw/vim-maximizer` | Maximize/restore the current split with `Space sm` |
| `hrsh7th/nvim-cmp` | Autocompletion engine with buffer, path, LSP, and snippet sources |
| `L3MON4D3/LuaSnip` | Snippet engine (loaded via nvim-cmp) |
| `rafamadriz/friendly-snippets` | Preconfigured snippet collection |
| `onsails/lspkind.nvim` | VSCode-style icons in the completion menu |
| `numToStr/Comment.nvim` | Toggle comments with `gcc` / `gc` |

---

## Plugin Manager (lazy.nvim)

lazy.nvim is self-bootstrapping — on a new machine it installs itself automatically when you open nvim.

| Command | Action |
|---------|--------|
| `:Lazy` | Open plugin manager UI |
| `:Lazy sync` | Install + update all plugins |
| `:Lazy update` | Update plugins |
| `:Lazy clean` | Remove unused plugins |
| `:Lazy health` | Run health checks |

---

## Adding Plugins

Create a new file in `nvim/lua/haddagart/plugins/`. Each file returns a table with the plugin spec:

```lua
-- nvim/lua/haddagart/plugins/example.lua
return {
  "author/plugin-name",
  event = "VeryLazy",       -- load lazily (optional)
  config = function()
    require("plugin-name").setup({
      -- your options here
    })
  end,
}
```

Then run `:Lazy sync` inside nvim. That's it.

For multiple small plugins in one file:

```lua
return {
  { "plugin/one" },
  { "plugin/two", lazy = true },
}
```

---

## Tips for VSCode Refugees

| VSCode habit | Vim equivalent |
|-------------|---------------|
| `Cmd+S` | `Space w` |
| `Cmd+W` | `Space bd` |
| `Cmd+B` (sidebar) | `Space ee` |
| `Cmd+P` (file picker) | `:Telescope find_files` (once Telescope is added) |
| `Cmd+Shift+F` (search) | `:Telescope live_grep` (once Telescope is added) |
| `Cmd+/` (comment) | `gcc` |
| Alt+Up/Down (move line) | `Alt+j` / `Alt+k` |
| Click to place cursor | `hjkl` + motions (resist the urge to use the mouse) |
| Multi-cursor | Visual Block `Ctrl+v` + `I` or use a plugin |
| Integrated terminal | `:terminal` or a terminal plugin |

> **Biggest tip:** Disable the mouse for the first few weeks (`vim.opt.mouse = ""`). It forces you to learn motions instead of reaching for the trackpad.

---

## Learning Path

**Week 1 — Survival**
- Move with `hjkl`
- Enter/exit insert with `i` and `jk`
- Save with `Space w`, quit with `Space q`
- Undo with `u`, redo with `Ctrl+r`
- Toggle the file tree with `Space ee`

**Week 2 — Efficiency**
- Use `w b e` instead of holding arrow keys
- Learn `dd yy cc` for whole lines
- Use `o O` to open lines
- Use `/` to search
- Comment lines with `gcc`

**Week 3 — Composing**
- Start using verb+noun: `diw`, `ci"`, `ya(`
- Use `f{char}` for in-line jumps
- Use visual mode `v V Ctrl+v` for selections
- Use autocompletion with `Ctrl+j/k` and `Enter`

**Week 4 — Fluency**
- Use `*` to search word under cursor
- Use `%` to jump between brackets
- Use `Ctrl+d/u` for page scrolling
- Use splits and tmux navigation together
- Run `:Tutor` inside nvim for interactive practice

> Run `:Tutor` anytime — it's built into nvim and takes ~30 minutes.
