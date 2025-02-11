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
      startWhenNeeded = true;
      allowSFTP = true;
      openFirewall = true;
      ports = [ 2257 ];

      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        AuthenticationMethods = "publickey";      
        PubkeyAuthentication = "yes";
        ChallengeResponseAuthentication = "no";
        UsePAM = false;
        X11Forwarding = false;
        LogLevel = "VERBOSE";
      };
    };
  };
}
