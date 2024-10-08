{ pkgs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.chrome;
in {
  options = {
    module.chrome.enable = mkEnableOption "Enables Google Chrome";
  };

  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.google-chrome;

      extensions = [
        # ublock origin lite
        { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; }
        # sponsorblock
        { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; }
      ];

      commandLineArgs = [
        "--ozone-platform=wayland"
        "--ozone-platform-hint=auto"
        "--gtk-version=4"
        "--ignore-gpu-blocklist"
      ];
    };
  };
}

