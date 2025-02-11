{ isWorkstation
, isLinux
, hyprlandEnable ? false
, swayEnable ? false
, wmEnable ? false
, ...
}:

{
  nixpkgs.overlays = [  ];

  stylix.targets = {
    vscode.enable = false;
    helix.enable  = false;
  };

  module = {
    wezterm.enable    = isWorkstation;
    vscode.enable     = isWorkstation;
    zed-editor.enable = isWorkstation;
    zathura.enable    = isWorkstation;
    stylix.enable     = isWorkstation;
    mpv.enable        = isWorkstation;

    floorp.enable  = isLinux && isWorkstation;
    foot.enable    = isLinux && isWorkstation;
    mpd.enable     = isLinux && isWorkstation;
    ssh.enable     = isLinux && isWorkstation;

    hyprland.enable = hyprlandEnable && isLinux && isWorkstation;
    hyprlock.enable = hyprlandEnable && isLinux && isWorkstation;

    sway.enable     = swayEnable && isLinux && isWorkstation;
    swaylock.enable = swayEnable && isLinux && isWorkstation;

    hypridle.enable = wmEnable && isLinux && isWorkstation;
    waybar.enable   = wmEnable && isLinux && isWorkstation;
    wofi.enable     = wmEnable && isLinux && isWorkstation;
    swaync.enable   = wmEnable && isLinux && isWorkstation;

    btop.enable           = true;
    eza.enable            = true;
    git.enable            = true;
    fzf.enable            = true;
    htop.enable           = true;
    ripgrep.enable        = true;
    fastfetch.enable      = true;
    tealdeer.enable       = true;
    nvim.enable           = true;
    helix.enable          = true;
    password-store.enable = true;
    zsh.enable            = true;
    fish.enable           = true;
    zoxide.enable         = true;
    yazi.enable           = true;

    user = {
      xdg.enable          = isLinux && isWorkstation;
      variables.enable    = isLinux && isWorkstation;
      impermanence.enable = isLinux;
      shellAliases.enable = true;
      packages.enable     = true;
    };
  };
}

