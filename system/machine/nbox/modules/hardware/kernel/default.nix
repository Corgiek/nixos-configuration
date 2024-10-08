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
    ];

    initrd.kernelModules = [
      "i915"
    ];

    kernelParams = [ 
      # Video driver settings
      "i915.enable_guc=1"
      "i915.enable_fbc=1"
      "pci=assign-busses,hpbussize=0x33,realloc"
      # Touchpad tune
      "psmouse.synaptics_intertouch=1"
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

