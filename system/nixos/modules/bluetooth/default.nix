{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.boot;
in {
  options = {
    module.bluetooth = {
      enable = mkEnableOption "Enables Bluetooth";
    };
  };

  config = mkIf cfg.enable {
    services.blueman.enable = true;

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.bluez5-experimental;

      settings = {
	      General = {
            Enable = "Source,Sink,Media,Socket";
            AutoEnable = true;
		        Experimental = true;
	      };
      };
    };
  };
}
