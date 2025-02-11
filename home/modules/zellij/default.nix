{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.zellij;
in {
  options = {
    module.zellij.enable = mkEnableOption "Enables zellij";
  };

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;

      settings = {
        scroll_buffer_size = 15000;
        simplified_ui = true;
        layout = "compact";
      };
    };

    xdg.configFile."zellij/layouts/default.kdl".text = ''
      layout {
        pane borderless=true
        pane size=1 borderless=true {
          plugin location="zellij:tab-bar"
        }
      }
    '';
  };
}

