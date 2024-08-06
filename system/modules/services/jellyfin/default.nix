{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.jellyfin;
in {
  options = {
    module.services.jellyfin.enable = mkEnableOption "Enable jellyfin";
  };

  config = mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
}
