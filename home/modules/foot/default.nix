{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.foot;
in {
  options = {
    module.foot.enable = mkEnableOption "Enables Foot";
  };

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      server.enable = true;

      settings = {
        main = {
          app-id = "foot";
          title = "foot";
          locked-title = "no";
          term = "xterm-256color";
          resize-delay-ms = 100;
          workers = 16;
          initial-window-size-chars = "115x24";
          pad = "12x21 center";
        };

        cursor = {
          style = "beam";
          beam-thickness = 2;
        };

        mouse = {
          hide-when-typing = "no";
        };

        key-bindings = {
          clipboard-copy = "Control+c XF86Copy";
          clipboard-paste = "Control+v XF86Paste";
        };

        text-bindings = {
          "\\x03" = "Control+Shift+c Control+Shift+C";
        };
      };
    };
  };
}
