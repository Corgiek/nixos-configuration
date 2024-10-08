{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.sshd;
in {
  options = {
    module.services.sshd.enable = mkEnableOption "Enable ssh";
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
