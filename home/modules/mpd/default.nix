{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.module.mpd;
in {
  options = {
    module.mpd.enable = mkEnableOption "Enables MPD and Ncmpcpp";
  };

  config = mkIf cfg.enable {
    services.mpd = {
      enable = true;
      package = pkgs.mpd;
      network.port = 6600;
      musicDirectory = "/home/corg/Music";

      extraConfig = ''
        audio_output {
        type            "pipewire"
        name            "PipeWire Sound Server"
        }
      '';
    };

    programs.ncmpcpp.enable = true;
    programs.ncmpcpp.mpdMusicDir = "/home/corg/Music";
    services.mpd-mpris.enable = true;
    services.mpd-mpris.mpd.useLocal = true;
  };
}
