{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.firefox;
in {
  options = {
    module.firefox.enable = mkEnableOption "Enables firefox";
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.floorp;

      settings = {
        "browser.translations.enable" = false;
        "geo.enabled" = false;
        "media.ffmpeg.vaapi.enabled" = true;
        "gfx.webrender.all" = true;
        "gfx.webrender.compositor" = true;
      };
    };
  };
}

