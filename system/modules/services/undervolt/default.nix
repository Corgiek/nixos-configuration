{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.undervolt;
in {
  options = {
    module.services.undervolt.enable = mkEnableOption "Enable undervolt";
  };

  config = mkIf cfg.enable {
    services.undervolt = {
      enable = true;
      tempBat    = 80;
      tempAc     = 80;
      coreOffset = -102;
      gpuOffset  = -102;
    };
  };
}

