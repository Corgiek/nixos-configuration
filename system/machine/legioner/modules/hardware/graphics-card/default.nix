{ pkgs
, config
, ...
}:

{
  # Graphics card settings
  nixpkgs.overlays = [
    (import ../../../../../overlays/vaapiIntel)
  ];

  services.xserver.videoDrivers = [ "nvidia" ];    

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    nvidiaSettings = false;

    package = config.boot.kernelPackages.nvidiaPackages.beta;

    prime = {
      sync.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      mesa
      intel-media-driver
      nvidia-vaapi-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}

