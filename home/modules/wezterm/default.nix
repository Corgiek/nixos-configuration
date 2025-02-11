{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.wezterm;
in {
  options = {
    module.wezterm = {
      enable = mkEnableOption "Enable wezterm";
    };
  };

  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = ''
        local wez = require('wezterm')
        return {
          cell_width = 0.85,

          -- Performance
          --------------
          front_end        = "WebGpu",
          webgpu_power_preference = 'HighPerformance'
          enable_wayland   = true,
          scrollback_lines = 1024,

          -- Fonts
          --------
          font         = wez.font_with_fallback({ 
          "Departure Mono",
          }),
          font_size = 11,
          initial_rows = 18,
          initial_cols = 85,
          dpi = 96.0,
          bold_brightens_ansi_colors = true,
          --font_antialias = "Subpixel",
          --font_hinting = "VerticalSubpixel",
          line_height       = 1.15,
          harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },

          -- Bling
          --------
          color_scheme   = "followSystem",
          window_padding = {
            left = "32pt", right = "32pt",
            bottom = "32pt", top = "32pt"
          },
          default_cursor_style = "SteadyUnderline",
          enable_scroll_bar    = false,
          warn_about_missing_glyphs = false,

          -- Tabbar
          ---------
          enable_tab_bar               = true,
          use_fancy_tab_bar            = false,
          hide_tab_bar_if_only_one_tab = true,
          tab_max_width                = 30,
          switch_to_last_active_tab_when_closing_tab = true,
          tab_bar_at_bottom            = true,
          show_tab_index_in_tab_bar    = false,

          -- Miscelaneous
          ---------------
          window_close_confirmation = "NeverPrompt",
          inactive_pane_hsb         = { 
            saturation = 1.0, brightness = 0.8
          },
          check_for_updates = false,
          hide_mouse_cursor_when_typing = true,
          window_background_opacity = 1
        }
      '';
    };
  };
}

