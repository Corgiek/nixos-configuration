{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.ssh;
in {
  options = {
    module.services.ssh.enable = mkEnableOption "Enable ssh";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [ 2257 ];

      settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      X11Forwarding = false;
      LogLevel = "VERBOSE";
      };
    };
  };
}
