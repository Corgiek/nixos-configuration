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
        gpu = {
            apply_gpu_optimisations = "accept-responsibility";
            gpu_device = 1;
        };
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
          pkgs.steam-run
          pkgs.gperftools
          pkgs.pkgsi686Linux.gperftools
        ];
        extraEnv = {
          # support cyrillic symbols
          LANG = "ru_RU.UTF-8";
        };
        extraBwrapArgs = [
          "--bind $HOME/Games/steamhome $HOME"
          "--bind $HOME/Games/Steam $HOME/.local/share/Steam"
        ];
      };
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
  };
  
  environment.systemPackages = with pkgs; [
    mangohud
    wineWow64Packages.unstableFull
    wineWow64Packages.wayland
    lutris
    dualsensectl

    # Minecraft Libs
    openal
    glfw-wayland-minecraft
    graalvm-ce
  ];

  services.udev.extraRules = ''
    # PS5 DualSense controller over USB hidraw
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ce6", MODE="0660", TAG+="uaccess"

    # PS5 DualSense controller over bluetooth hidraw
    KERNEL=="hidraw*", KERNELS=="*054C:0CE6*", MODE="0660", TAG+="uaccess"
  '';
  };
}
