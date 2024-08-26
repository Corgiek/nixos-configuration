{ config
, lib
, pkgs
, inputs
, isWorkstation
, wmEnable
, ...
}:

with lib;

let
  inherit (pkgs.stdenv) isLinux;
  cfg = config.module.users.corg.packages;
in {
  options.module.users.corg.packages = {
    enable = mkEnableOption "Enable corg packages";
  };

  config = mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      # Utils
      bat
      tokei
      shellcheck
      pre-commit
      deadnix
      statix
      ffmpeg
      inputs.any-nix-shell

      # Programming
      go
      python3
      lldb

      # DevOps Utils
      docker-compose
      kubectl
      kubernetes-helm
      ansible
      ansible-lint
      terraform

      # Security
      age
      sops
      grype
      syft
    ] ++ lib.optionals isWorkstation [
      # Chats
      discord

      # Text Editors
      obsidian

      # Minecraft
      prismlauncher

      # Security
      semgrep

      # Fonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" "UbuntuMono" "Iosevka" ]; })
      corefonts
    ] ++ lib.optionals (isLinux && isWorkstation) [
     # DevOps Utils
      vagrant

      # Chats
      telegram-desktop
      vesktop

      # OBS & plugins
      obs-studio
      obs-studio-plugins.obs-vkcapture
      obs-studio-plugins.input-overlay
      obs-studio-plugins.obs-pipewire-audio-capture

      # Wine
      wineWow64Packages.unstableFull
      lutris

      # Misc
      dconf2nix
      gpick
      gat
      eog
    ] ++ lib.optionals wmEnable [
      imagemagick
      grim
      slurp
      wl-clipboard
      wl-screenrec
      wayland
      hyprpicker
      waypaper
      cliphist
      imv
      gtk3
      dbus
      glib
      swww
      xdg-utils
      pavucontrol
      nemo
      eww
      networkmanagerapplet
      brightnessctl
    ];
  };
}

