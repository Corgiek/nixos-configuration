{ pkgs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.xserver;
in {
  options = {
    module.services.xserver.enable = mkEnableOption "Enable xserver";
  };

  config = mkIf cfg.enable {
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      konsole
      oxygen
    ];

    services = {
      desktopManager.plasma6.enable = true;
      displayManager = {
        sddm.enable = true;
        defaultSession = "plasma";
      };

      xserver = {
        enable = true;
        libinput.enable = true;

        xkb = {
          layout = "us";
          variant = "";
        };
      };
    };
  };
}

