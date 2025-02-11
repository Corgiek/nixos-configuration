_:

{
  module = {
    sound.enable          = true;
    bluetooth.enable      = true;
    lanzaboote.enable     = true;
    locales.enable        = true;
    network.enable        = true;
    timedate.enable       = true;
    users.enable          = true;
    variables.enable      = true;
    virtualisation.enable = true;
    stylix.enable         = true;
    minimal.enable        = true;
    nixos-ng.enable       = true;

    security = {
      enable            = true;
      enableBootOptions = true;
      disableIPV6       = true;
    };

    services = {
      bolt.enable         = true;
      tlp.enable          = true;
      fwupd.enable        = true;
      polkit.enable       = true;
      udev.enable         = true;
      zram.enable         = true;
      greetd.enable       = true;
      oomd.enable         = true;

      scx = {
        enable = true;
        schedulerType = "scx_bpfland";
      };
    };

    programs = {
      dconf.enable          = true;
      gnupg.enable          = true;
      hm.enable             = true;
      nh.enable             = true;
      xdg-portal.enable     = true;
      zsh.enable            = true;
      fish.enable           = true;
      systemPackages.enable = true;
    };
  };
}

