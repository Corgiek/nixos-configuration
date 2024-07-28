{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.user-dirs;
in {
  options = {
    module.user-dirs.enable = mkEnableOption "Enables xdg user-dirs";
  };

  config = mkIf cfg.enable {
    xdg.userDirs = {
      enable = true;
      music = "/home/corg/Music";
      pictures = "/home/corg/Images";
      templates = null;
      desktop = null;
    };
  };
}

