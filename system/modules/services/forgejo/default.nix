{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.forgejo;
in {
  options = {
    module.services.forgejo.enable = mkEnableOption "Enable forgejo";
  };

  config = mkIf cfg.enable {
    services.forgejo = {
      enable = true;
      lfs.enable = true;

      settings = {
        server.SSH_PORT = 2257;
      };
    };
  };
}

