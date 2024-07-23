{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.ssh;
in {
  options = {
    module.ssh.enable = mkEnableOption "Enables ssh client";
  };

  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      compression = true;
    };
  };
}

