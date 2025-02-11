{ config
, lib
, ...
}:

with lib;

let
  cfg = config.module.zathura;
in {
  options = {
    module.zathura.enable = mkEnableOption "Enables zathura";
  };

  config = mkIf cfg.enable {
    programs.zathura = {
      enable = true;

      options = {
        selection-clipboard = "clipboard";
        synctex-editor-command = "foot nvim";       
        scroll-page-aware = "true";
        scroll-full-overlap = "0.01";
        scroll-step = "100";
        smooth-scroll = true;
        zoom-min = "10";
      };
    };
  };
}

