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

      settings = {
        scroll_buffer_size = 15000;
        simplified_ui = true;
      };
    };
  };
}

