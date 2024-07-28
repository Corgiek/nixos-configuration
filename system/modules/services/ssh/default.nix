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
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
      ports = [ 2257 ];
    };
  };
}
