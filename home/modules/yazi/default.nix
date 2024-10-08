{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.yazi;
in {
  options = {
    module.yazi.enable = mkEnableOption "Enables yazi";
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;

      settings = {
        log.enabled = false;

        manager = {
          sort_dir_first = true;
          sort_reverse = true;
          sort_sensitive = true;
          linemode = "size";
          show_symlink = true;
        };
      };
    };
  };
}

