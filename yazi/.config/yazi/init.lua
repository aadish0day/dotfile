-- Starship prompt
require("starship"):setup()

-- Full border
require("full-border"):setup {
    -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
    type = ui.Border.ROUNDED,
}

-- KDE Connect - always show device selection
require("kdeconnect-send"):setup({
    auto_select_single = false,
})
