{
  nixos = {
    pcbox = {
      username      = "corg";
      platform      = "x86_64-linux";
      stateVersion  = "24.11";
      isWorkstation = true;
      wm            = "sway";
    };

    nbox = {
      username      = "corg";
      platform      = "x86_64-linux";
      stateVersion  = "24.11";
      isWorkstation = true;
      wm            = "sway";
    };

    rasp = {
      username      = "corg";
      platform      = "aarch64-linux";
      stateVersion  = "24.11";
      isWorkstation = false;
    };
  };

  darwin = {
    macbox = {
      username      = "corg";
      platform      = "aarch64-darwin";
      stateVersion  = 6;
      isWorkstation = true;
    };
  };
}

