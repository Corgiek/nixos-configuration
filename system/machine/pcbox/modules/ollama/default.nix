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
      acceleration = "rocm";
      rocmOverrideGfx = "8.0.3";

      environmentVariables = {
        HCC_AMDGPU_TARGET = "gfx803";
      };
    };
  };
}

