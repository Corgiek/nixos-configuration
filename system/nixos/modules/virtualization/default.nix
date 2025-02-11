{ lib
, config
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
      docker = {
        enable = true;
        extraPackages = with pkgs; [ docker-compose ];
        storageDriver = "btrfs";
      };

      kvmgt.enable = true;
      spiceUSBRedirection.enable = true;

      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true;
          swtpm.enable = true;
          ovmf = {
            enable = true;
          };
        };
      };
    };
  };
}
