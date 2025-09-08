-- Pull the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration
local config = wezterm.config_builder()


-- Helper: scheme switcher based on OS theme
local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "Catppuccin Mocha"
  else
    return "Catppuccin Latte"
  end
end

-- Helper: Tab colors based on OS theme
local function tab_colors_for_appearance(appearance)
  if appearance:find("Dark") then
    return {
      tab_bar = {
        background = "#1e1e2e", -- dark bg
        active_tab = {
          bg_color = "#89b4fa",
          fg_color = "#1e1e2e",
          intensity = "Bold",
        },
        inactive_tab = {
          bg_color = "#313244",
          fg_color = "#cdd6f4",
        },
        inactive_tab_hover = {
          bg_color = "#45475a",
          fg_color = "#ffffff",
        },
        new_tab = {
          bg_color = "#181825",
          fg_color = "#cdd6f4",
        },
        new_tab_hover = {
          bg_color = "#89b4fa",
          fg_color = "#1e1e2e",
          italic = true,
        },
      },
    }
  else
    return {
      tab_bar = {
        background = "#F33", -- light bg
        active_tab = {
          bg_color = "#abcbf2",
          fg_color = "#073e81",
          intensity = "Bold",
        },
        inactive_tab = {
          bg_color = "#d0d0d0",
          fg_color = "#444444",
        },
        inactive_tab_hover = {
          bg_color = "#c0c0c0",
          fg_color = "#000000",
        },
        new_tab = {
          bg_color = "#eaeaea",
          fg_color = "#444444",
        },
        new_tab_hover = {
          bg_color = "#3584e4",
          fg_color = "#ffffff",
          italic = true,
        },
      },
    }
  end
end

return {
  -- Font settings
  font = wezterm.font_with_fallback {
    "CaskaydiaCove Nerd Font Mono",
    "JetBrainsMono Nerd Font",  
    "FiraCode Nerd Font",
    "Cascadia Code PL",
  },
  font_size = 13.0,

  -- Theme settings
  color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
  colors = tab_colors_for_appearance(wezterm.gui.get_appearance()),
  window_background_opacity = 0.9,
  macos_window_background_blur = 20,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = true,
  tab_bar_at_bottom = true,

  -- Cursor settings
  default_cursor_style = "BlinkingUnderline",
  cursor_blink_rate = 600, -- slower, elegant blink
  cursor_blink_ease_in = "EaseIn",
  cursor_blink_ease_out = "EaseOut",

  -- 🚀 Keybindings
  keys = {
    -- --- Tabs ---
    { key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab "CurrentPaneDomain" },
    { key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab { confirm = true } },
    { key = "Tab", mods = "CTRL", action = wezterm.action.ActivateTabRelative(1) },
    { key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },

    -- --- Splits ---
    { key = "h", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "d", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },

    -- --- Pane navigation (Warp-style) ---
    { key = "h", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection "Left" },
    { key = "l", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection "Right" },
    { key = "k", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection "Up" },
    { key = "j", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection "Down" },
    { key = "x", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane { confirm = true } },
    -- --- Pane resizing ---
    { key = "LeftArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize { "Left", 3 } },
    { key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize { "Right", 3 } },
    { key = "UpArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize { "Up", 2 } },
    { key = "DownArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize { "Down", 2 } },

    -- --- Copy/Paste/Search ---
    { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo "Clipboard" },
    { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom "Clipboard" },
    { key = "f", mods = "CTRL|SHIFT", action = wezterm.action.Search { CaseInSensitiveString = "" } },

    -- --- Command Palette ---
    { key = "p", mods = "CTRL|SHIFT", action = wezterm.action.ActivateCommandPalette },

    -- --- AI Tool Launcher (example) ---
    { key = "a", mods = "CTRL|SHIFT", action = wezterm.action.SpawnCommandInNewTab {
      args = { "ai-tool", "gemini" }
    }},
  },

  -- Scrollback
  scrollback_lines = 5000,
}