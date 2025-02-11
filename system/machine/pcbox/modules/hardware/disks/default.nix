_:

{
  services = {
    # clean zfs devices
    zfs.autoScrub = { 
      enable = true;
      interval = "weekly";
    };

    # zpool trim
    zfs.trim.enable = true;

    # discard blocks that are not in use by the filesystem, good for SSDs health
    fstrim = {
      enable = true;
      interval = "weekly";
    };
  };

  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=25%" "mode=755" ];
    };

    "/persist" = {
      options = [ "compress=zstd:5" "subvol=persist" "noatime" ];
      neededForBoot = true;
    };

    "/nix" = {
      options = [ "compress=zstd:5" "subvol=nix" "noatime" ];
      neededForBoot = true;
    };    

    "/home/corg/hdd" = {
      device = "hdd";
      fsType = "zfs";
      neededForBoot = true;
    };

    "/home/corg/hdd/randomstuff" = {
      device = "hdd/randomstuff";
      fsType = "zfs";
      neededForBoot = true;
    };
  };

  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-CL4-3D256-Q11_NVMe_SSSTC_256GB_TW0M3TJT9DH0034B04M9";

        content = {
          type = "gpt";

          partitions = {
            esp = {
              size = "1G";
              type = "EF00";

              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";

                mountOptions = [ "defaults" "umask=0077" ];
              };
            };

            luks = {
              size = "100%";

              content = {
                type = "luks";
                name = "crypted";

                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];

                  subvolumes = {
                    "/persist" = {
                      mountpoint   = "/persist";
                      mountOptions = [ "compress=zstd:5" "subvol=persist" "noatime" ];
                    };

                    "/nix" = {
                      mountpoint   = "/nix";
                      mountOptions = [ "compress=zstd:5" "subvol=nix" "noatime" ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [ "mode=755" "size=25%" ];
      };
    };
  };
}

