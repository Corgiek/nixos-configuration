{ 
...
}:

{
  fileSystems = {
    "/" = {
      fsType = "tmpfs";
      options = [ "mode=755" "size=10G" ];
    };

    "/nix" = {
      options = [ "compress=zstd:4" "subvol=nix" ];
    };

    "/persist" = {
      neededForBoot = true;
      options = [ "compress=zstd:4" "subvol=persist" ];
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
              size = "512M";
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
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress=zstd:4" "noatime" ];
                    };

                    "/persist" = {
                      mountpoint = "/persist";
                      mountOptions = [ "compress=zstd:4" ];
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
        mountOptions = [ "mode=755" "size=10G" ];
      };
    };
  };
}


