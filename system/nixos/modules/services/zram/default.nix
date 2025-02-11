{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.zram;
in {
  options = {
    module.services.zram.enable = mkEnableOption "Enable zram";
  };

  config = mkIf cfg.enable {
    zramSwap = {
      enable = true;
      priority = 1000;
      algorithm = "zstd";
      swapDevices = 1;
      memoryPercent = 80;
    };

    boot = {
      kernelParams = [
        "zswap.enabled=0"
      ];

      kernel.sysctl = {
        # Disable swap readahead
        "vm.page-cluster" = 0;
        # Compressing a page is cheaper than major mmap pagefault
        "vm.swappiness" = 180;    
        "vm.watermark_boost_factor" = 0;
        "vm.watermark_scale_factor" = 125;
      };
    };
  };
}

