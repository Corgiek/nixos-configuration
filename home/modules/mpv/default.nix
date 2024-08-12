{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.mpv;
in {
  options = {
    module.mpv.enable = mkEnableOption "Enables mpv";
  };

  config = mkIf cfg.enable {
    programs.mpv = {
      enable = true;

    config =  {
      profile = "gpu-hq";
      force-window = true;
      hwdec = auto;
      ao = "pipewire,alsa,coreaudio";
      ytdl-format = "bestvideo+bestaudio";
      cache-default = 4000000;
    };

    };
  };
}

