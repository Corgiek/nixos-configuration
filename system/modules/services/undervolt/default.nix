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
      tempBat    = 85;
      tempAc     = 92;
      coreOffset = -135;
      gpuOffset  = -139;
    };
  };
}

