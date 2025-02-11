{ pkgs
, ...
}:

{
  boot = {
    kernelPackages = pkgs.linuxPackages;

    supportedFilesystems = [
      "zfs" 
    ];

    kernelModules = [
      "amdgpu"
      "kvm-amd"
      "kvm-intel"
      "tls"
      "tcp_bbr"
    ];

    extraModulePackages = [ ];

    kernelParams = [
      "drm_kms_helper.poll=0"
    ];

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];

      kernelModules = [
        "amdgpu"
      ];
    };
  };
}

