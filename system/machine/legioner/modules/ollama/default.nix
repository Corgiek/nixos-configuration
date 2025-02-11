{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.ollama.gpuSupport;
in {
  options = {
    module.services.ollama.gpuSupport.enable = mkEnableOption "Enable gpuSupport for ollama";
  };

  config = mkIf cfg.enable {
    services.ollama = {
      acceleration = "cuda";
    };
  };
}

