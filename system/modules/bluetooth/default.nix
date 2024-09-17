{ lib
, config
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
    hardware.bluetooth = {
      enable = true;

      settings = {
	        General = {
            Enable = "Source,Sink,Media,Socket";
            AutoEnable = true;
		        Experimental = true;
	        };
        };
      };

    services.blueman.enable = true;
  };
}