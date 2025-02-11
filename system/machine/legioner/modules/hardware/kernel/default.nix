{ pkgs
, ...
}:

{
  # Kernel settings
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;

    extraModulePackages = [ ];

    kernelModules = [
      "kvm-intel"
      "tcp_bbr"
      "tls"
    ];

    initrd.kernelModules = [
      "i915"
    ];

    blacklistedKernelModules = [
      "nouveau"
    ];

    kernelParams = [ 
      # Video driver settings
      "i915.enable_guc=1"
      "i915.enable_fbc=1"
      "i915.fastboot=1"
      "enable_gvt=1"
      "nvidia_drm.fbdev=1"
      "pci=assign-busses,hpbussize=0x33,realloc"
    ];

    initrd.availableKernelModules = [ 
      "xhci_pci"
      "thunderbolt"
      "vmd"
      "nvme"
      "usb_storage"
      "sd_mod"
    ];
  };
}

