{ inputs
, ...
}:

{
  imports = [
    inputs.disko.nixosModules.disko
  ];

  disko.devices = {
    disk = {
      vdb = {
        type = "disk";
        device = "/dev/sda";

        content = {
          type = "gpt";

          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";

              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";

                mountOptions = [
                  "defaults"
                ];
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
                      mountOptions = [ "compress=zstd:5" "noatime" ];
                    };

                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [ "compress=zstd:5" "noatime" ];
                    };

                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress=zstd:5" "noatime" ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}

