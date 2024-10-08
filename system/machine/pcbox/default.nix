{ hyprlandEnable
, config
, ...
}:

{
  module = {
    sound.enable          = true;
    boot.enable           = true;
    locales.enable        = true;
    network.enable        = true;
    timedate.enable       = true;
    users.enable          = true;
    variables.enable      = true;
    virtualisation.enable = true;
    stylix.enable         = true;
    minimal.enable        = true;
    nixos-ng.enable       = true;
    gaming.enable         = true;

    chaotic = {
      enable = true;
      schedulerType = "scx_bpfland";
    };

    security = {
      enable            = true;
      enableBootOptions = true;
      disableIPV6       = true;
    };

    services = {
      bolt.enable              = true;
      fwupd.enable             = true;
      polkit.enable            = true;
      syncthing.enable         = true;
      udev.enable              = true;
      zram.enable              = true;
      greetd-tui.enable        = true;
      jellyfin.enable          = true;
      mediamtx.enable          = true;
      forgejo.enable           = true;
      sshd.enable              = true;
      tailscale.enable         = true;

      hyprland.enable = hyprlandEnable;

      ollama = {
        enable            = true;
        gpuSupport.enable = config.services.ollama.enable;
      };
    };

    programs = {
      dconf.enable          = true;
      gnupg.enable          = true;
      hm.enable             = true;
      nh.enable             = true;
      mtr.enable            = true;
      xdg-portal.enable     = true;
      zsh.enable            = true;
      fish.enable           = true;
      systemPackages.enable = true;
    };
  };
}

