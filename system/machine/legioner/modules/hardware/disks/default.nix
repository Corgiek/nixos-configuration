_:

{
  services = {
    # clean btrfs devices
    btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
      fileSystems = [ "/persist" "/persist/home/corg/mounts/ssd" ];
    };

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

    "/persist/home/corg/mounts/ssd" = {
      device = "/dev/disk/by-id/ata-Samsung_SSD_870_EVO_500GB_S6PYNM0T604172Z";
      fsType = "btrfs";
      options = [ "compress=zstd:5" "noatime" ];
    };
  };

  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-Micron_2200V_MTFDHBA512TCK__200926FF1662";

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
                    "/root" = {
                      mountpoint = "/";
                    };

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

