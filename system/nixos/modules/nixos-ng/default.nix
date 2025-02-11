{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.nixos-ng;
in {
  options = {
    module.nixos-ng = {
      enable = mkEnableOption "Enables nixos-ng";
    };
  };

  config = mkIf cfg.enable {
    boot.initrd.systemd.enable = true;
    
    # WARNING: this is an experimental feature, and it is not enabled by default
    # and this will create users with a different script then the perl one
    # so it may cause breakages, be warned
    #systemd.sysusers.enable = true;

    services = {
      # userborn.enable     = true;
      dbus.implementation = "broker";
    };

    system = {
      switch = {
        enable = false;
        enableNg = true;
      };

      # Mount /etc as an overlayfs instead of generating it via a perl script.
      # WARNING: do not enable this if your not confident in your ability to fix it
      # it is a royal pain and is not worth half the effor it takes to fix it
      /* etc.overlay = {
        enable = true;
        mutable = false;
      }; */

      # we can use this to warn us if we have perl installed
      # forbiddenDependenciesRegexes = [ "perl" ];
    };
  };
}
