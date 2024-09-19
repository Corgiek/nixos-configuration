{ lib
, config
, username
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.virtualisation;
in {
  options = {
    module.virtualisation = {
      enable = mkEnableOption "Enables virtualisation";
    };
  };

  config = mkIf cfg.enable {
    # Virtualization settings
    environment.systemPackages = with pkgs; [
      virt-manager
    ];

    virtualisation = {
      podman = {
        enable = true;

        # Create a `docker` alias for podman, to use it as a drop-in replacement
        dockerCompat = true;
        dockerSocket.enable = true;

        extraPackages = with pkgs; [ podman-compose ];

        # Required for containers under podman-compose to be able to talk to each other.
        # For Nixos version > 22.11
        defaultNetwork.settings = {
          dns_enabled = true;
        };
      };

      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true;
          swtpm.enable = true;
          ovmf = {
            enable = true;
            packages = [
              (unstable.OVMF.override {
                secureBoot = true;
                tpmSupport = true;
              }).fd
            ];
          };
        };
      };
    };
  };
}
