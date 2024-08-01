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

      extraConfig = ''
        audio_output {
        type            "pipewire"
        name            "PipeWire Sound Server"
        }
      '';
    };

    programs.ncmpcpp.enable = true;
    services.mpd-mpris.enable = true;
    services.mpd-mpris.mpd.port = 6600;
  };
}
