{
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.module.ncmpcpp;
in {
  options = {
    module.ncmpcpp.enable = mkEnableOption "Enables Ncmpcpp for MPD";
  };

  config = mkIf cfg.enable {
    programs.ncmpcpp = {
      enable = true;

      bindings = [
          { key = "j"; command = "scroll_down"; }
          { key = "k"; command = "scroll_up"; }
          { key = "J"; command = [ "select_item" "scroll_down" ]; }
          { key = "K"; command = [ "select_item" "scroll_up" ]; }
      ];
    };
  };
}
