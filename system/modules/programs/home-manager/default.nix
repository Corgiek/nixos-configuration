{ inputs
, lib
, pkgs
, config
, ...
}:

with lib;

let
  cfg = config.module.programs.hm;
in {
  options = {
    module.programs.hm.enable = mkEnableOption "Enable Home Manager";
  };

  config = mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup-" + pkgs.lib.readFile "${pkgs.runCommand "timestamp" {} "echo -n date '+%Y%m%d%H%M%S' > $out"}";
      extraSpecialArgs = {
        inherit inputs;
      };
    };
  };
}

