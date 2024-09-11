{ lib
, pkgs
, config
, ...
}:

{
  # Extra drivers settings
  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;

    firmware = with pkgs; [
      linux-firmware
    ];
  };
}

