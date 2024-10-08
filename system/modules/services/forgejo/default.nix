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
        session.COOKIE_SECURE = true;
        "cron.sync_external_users" = {
          RUN_AT_START = true;
          SCHEDULE = "@every 24h";
          UPDATE_EXISTING = true;
        };
      };
    };
  };
}

