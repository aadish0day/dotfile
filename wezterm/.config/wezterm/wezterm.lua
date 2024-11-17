local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Color scheme configuration
config.color_schemes = {
    ["Custom Alacritty"] = {
        foreground = "#e3e3ea",
        background = "#000000",
        cursor_bg = "#e3e3ea",
        cursor_border = "#e3e3ea",
        cursor_fg = "#000000",
        selection_bg = "#ff7f7f",
        selection_fg = "#FFFFFF",
        ansi = {
            "#808080", -- normal black
            "#ef2929", -- normal red
            "#8ae234", -- normal green
            "#fce94f", -- normal yellow
            "#739fcf", -- normal blue
            "#C388D1", -- normal magenta
            "#34e2e2", -- normal cyan
            "#d3d7cf", -- normal white
        },
        brights = {
            "#555753", -- bright black
            "#ef2929", -- bright red
            "#8ae234", -- bright green
            "#fce94f", -- bright yellow
            "#739fcf", -- bright blue
            "#E19FE7", -- bright magenta
            "#34e2e2", -- bright cyan
            "#eeeeec", -- bright white
        },
    },
}

-- Apply the color scheme
config.color_scheme = "Custom Alacritty"

-- Font configuration
config.font = wezterm.font("JetBrains Mono Nerd Font", { weight = "Bold" })
config.font_size = 10

-- Window configuration
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.window_background_opacity = 0.73
config.enable_tab_bar = false
config.warn_about_missing_glyphs = false

config.hide_mouse_cursor_when_typing = false

return config

