local wezterm = require('wezterm')

return {
    -- Font settings
    font = wezterm.font_with_fallback({
        'CaskaydiaCove Nerd Font Mono',
        'JetBrainsMono Nerd Font Mono',
        'Comic Code',
        'Menlo',
    }),
    font_size = 18.0,
    line_height = 1.75,

    -- Color and appearance
    color_scheme = 'Tomorrow (dark) (terminal.sexy)',
    enable_tab_bar = false,
    use_fancy_tab_bar = false,
    window_decorations = 'RESIZE',
    window_background_opacity = 0.95,
    window_padding = {
        left = '1.5cell',
        right = '1.5cell',
        top = '0.75cell',
        bottom = '0.5cell',
    },

    -- Scrollback
    enable_scroll_bar = false,
    scrollback_lines = 100000,
}
