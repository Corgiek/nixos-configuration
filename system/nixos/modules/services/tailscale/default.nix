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
    networking.firewall = {
      # always allow traffic from your Tailscale network
      trustedInterfaces = [ "tailscale0" ];

      # allow the Tailscale UDP port through the firewall
      allowedUDPPorts = [ 41641 ];
    };

    services.tailscale = {
      enable = true;
      permitCertUid = "root";
    };
  };
}
