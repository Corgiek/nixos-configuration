{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.mediamtx;
in {
  options = {
    module.services.mediamtx.enable = mkEnableOption "Enable mediamtx";
  };

  config = mkIf cfg.enable {
    services.mediamtx = {
      enable = true;
    };
  };
}
