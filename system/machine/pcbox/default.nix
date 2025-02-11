{
  config,
  ...
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
    minimal.enable        = true;
    nixos-ng.enable       = true;

    programs = {
      hm.enable             = true;
      gnupg.enable = true;
      fish.enable = true;
      zsh.enable = true;
      systemPackages.enable = true;
    };

    security = {
      enable = true;
      enableBootOptions = true;
    };

    defaults = {
      network = {
        iface = "enp0s31f6";
        ip = "192.168.0.103";
        gw = "192.168.1.1";
        mask = "255.255.255.0";
        cidr = "24";
      };

      ssh.pubKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIXByEG3SJJOMxKEAl8azfR/fNMuvXfNcCaEFrdIdn91"
      ];
    };

    services = {
      zram.enable         = true;
      jellyfin.enable     = true;
      mediamtx.enable     = true;
      forgejo.enable      = true;
      valkey.enable       = true;
      sshd.enable         = true;
      tailscale.enable    = true;
      oomd.enable         = true;

      proxmox-ve = {
        enable = true;
        ipAddress = config.module.defaults.network.ip;
      };

      ssh = {
        enable = true;
        listenAddresses = [
          {
            addr = config.module.defaults.network.ip;
            port = 45631;
          }
        ];
      };
    };
  };

  nix.settings.trusted-users = [
    "corg"
    "root"
  ];
}
