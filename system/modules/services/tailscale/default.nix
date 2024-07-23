{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.tailscale;
in {
  options = {
    module.services.tailscale.enable = mkEnableOption "Enable tailscale";
  };

  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
    };
  };
}
