{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.undervolt;
in {
  options = {
    module.services.undervolt.enable = mkEnableOption "Enable cpu-autofreq";
  };

  config = mkIf cfg.enable {
    services.undervolt = {
      enable = true;

      coreOffset = -100;

      gpuOffset  = -100;
    };
  };
}

