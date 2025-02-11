{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.boot;
in {
  options = {
    module.boot = {
      enable = mkEnableOption "Enables Bootloader";
    };
  };

  config = mkIf cfg.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        # prevent "too many" configuration from showing up on the boot menu      
        configurationLimit = 15;
        # the default is "keep"
        consoleMode = "max"; 
        # Fix a security hole. See desc in nixpkgs/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix
        editor = false;
      };
    };
  };
}

