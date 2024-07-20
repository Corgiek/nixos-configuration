{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.gaming;
in {
  options = {
    module.gaming.enable = mkEnableOption "Enables things needed for gaming";
  };

  config = mkIf cfg.enable {
    programs = {
      gamemode = {
        enable = true;

        settings = {
            general = {
            softrealtime = true;
        };
        # gpu = {
        #   apply_gpu_optimisations = "accept-responsibility";
        #   gpu_device = 0;
        # };

        # custom = {
        #  start = "$HOME/magic/hyprgamemode.sh"; # TODO: fix
        #  end = "hyprctl reload";
        # };
      };
    };

    gamescope = {
      enable = true;
      capSysNice = true;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      package = pkgs.steam.override {
        extraPkgs = pkgs: [
          pkgs.gperftools
          pkgs.pkgsi686Linux.gperftools
        ];
      };
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
  };
};
}
