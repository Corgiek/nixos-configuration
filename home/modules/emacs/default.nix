{ inputs
, config
, lib
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.emacs;
in {
  options = {
    module.emacs.enable = mkEnableOption "Enable emacs";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      emacs29-pgtk
      emacsPackages.vterm
      emacsPackages.python
      emacsPackages.emacsql
      emacsPackages.emacsql-sqlite
      emacsPackages.pdf-tools

      fd
      nerdfonts
      nil
     ];
  };
}

