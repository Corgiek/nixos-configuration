{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.services.valkey;
in {
  options = {
    module.services.valkey.enable = mkEnableOption "Enable valkey";
  };

  config = mkIf cfg.enable {
    services.redis = {
      package = pkgs.valkey;
      vmOverCommit = true;
      servers = {
        forgejo = mkIf config.services.forgejo.enable {
          enable = true;
          user = "forgejo";
          port = 6371;
          databases = 16;
          logLevel = "debug";
          requirePass = "forgejo";
        };
      };
    };
  };
}
