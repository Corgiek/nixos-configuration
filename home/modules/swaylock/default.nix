{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.swaylock;
in {
  options = {
    module.swaylock = {
      enable = mkEnableOption "Enable swaylock";
    };
  };

  config = mkIf cfg.enable {
    programs.swaylock = {
      enable = true;

      settings = {
        daemonize = true;
        clock = true;
        line-uses-ring = true;
        show-failed-attempts = true;
      };
    };
  };
}

