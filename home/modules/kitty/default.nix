{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.kitty;
in {
  options = {
    module.kitty.enable = mkEnableOption "Enables Kitty";
  };

  config = mkIf cfg.enable {
    # Terminal emulator kitty
    programs.kitty = {
      enable = true;

      shellIntegration = {
        enableZshIntegration = true;
       };

      settings = {
        term = "xterm-kitty";
        
        # Scrollback
        scrollback_lines = 10000;
        scrollback_pager = "less";
        wheel_scroll_multiplier = "5.0";

        # Display server
        linux_display_server = "wayland";
        wayland_enable_ime = "yes";

        # Performance
        repaint_delay = 20;
        input_delay = 2;
        sync_to_monitor = "no";
      };
    };
  };
}

