{
  nixos = {
    pcbox = {
      username = "corg";
      platform = "x86_64-linux";
      stateVersion = "25.05";
      isWorkstation = false;
    };

    legioner = {
      username = "corg";
      platform = "x86_64-linux";
      stateVersion = "25.05";
      isWorkstation = true;
      wm = "hyprland";
    };

    nbox = {
      username = "corg";
      platform = "x86_64-linux";
      stateVersion = "25.05";
      isWorkstation = true;
      wm = "sway";
    };

    rasp = {
      username = "corg";
      platform = "aarch64-linux";
      stateVersion = "25.05";
      isWorkstation = false;
    };
  };

  darwin = {
    macbox = {
      username = "corg";
      platform = "aarch64-darwin";
      stateVersion = 6;
    };
  };
}
