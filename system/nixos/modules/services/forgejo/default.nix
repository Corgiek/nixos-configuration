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
        federation.ENABLED = true;
        session.COOKIE_SECURE = true;

        server = {
          PROTOCOL = "http+unix";
          ROOT_URL = "https://femboysex.uwu";
          HTTP_PORT = 4485;
          DOMAIN = "femboysex.uwu";

          BUILTIN_SSH_SERVER_USER = "git";
          DISABLE_ROUTER_LOG = true;

          START_SSH_SERVER = true;
          SSH_CREATE_AUTHORIZED_KEYS_FILE = true;
          SSH_PORT = 2257;
          SSH_LISTEN_PORT = 2257;
        };

        "ui.meta" = {
          AUTHOR = "Corgie UwU";
          DESCRIPTION = "A super cool place to host git repos";
          KEYWORDS = "git,self-hosted,gitea,forgejo,open-source,nix,nixos";
        };

        actions = {
          ENABLED = true;
          DEFAULT_ACTIONS_URL = "https://code.forgejo.org";
        };

        database = {
          DB_TYPE = mkForce "postgres";
          HOST = "/run/postgresql";
          NAME = "forgejo";
          USER = "forgejo";
          PASSWD = "forgejo";
        };

        cache = {
          ENABLED = true;
          ADAPTER = "redis";
          HOST = "redis://:forgejo@localhost:6371";
        };

        # "cron.sync_external_users" = {
        # RUN_AT_START = true;
        # SCHEDULE = "@every 24h";
        # UPDATE_EXISTING = true;
        # };

        # backup
        dump = {
          enable = true;
          backupDir = "/srv/storage/forgejo/dump";
          interval = "06:00";
          type = "tar.zst";
        };
      };
    };
  };
}

