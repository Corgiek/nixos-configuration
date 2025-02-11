{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.tealdeer;
in {
  options = {
    module.tealdeer.enable = mkEnableOption "Enables tldr rust client";
  };

  config = mkIf cfg.enable {
    programs.tealdeer = {
      enable = true;

      settings = {
        updates.auto_update = false;
        display = {
          compact = false;
          use_pager = true;
        };
      };
    };
  };
}
