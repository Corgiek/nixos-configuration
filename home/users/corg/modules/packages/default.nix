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
  cfg = config.module.user.packages;
in {
  options.module.user.packages = {
    enable = mkEnableOption "Enable user packages";
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
      ffmpeg-full
      sshfs
      inputs.any-nix-shell

      # Security
      age
      sops
    ] ++ lib.optionals isWorkstation [
      # Chats
      discord

      # Text Editors
      obsidian

      # Minecraft
      prismlauncher

      # Misc
      qbittorrent

      # Fonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.ubuntu-mono
      nerd-fonts.iosevka
      departure-mono
      corefonts
    ] ++ lib.optionals (isLinux && isWorkstation) [
      inputs.ghostty.packages.x86_64-linux.default
      # Programming
      go
      python3

      # DevOps Utils
      docker-compose
      kubectl
      kubernetes-helm
      ansible
      ansible-lint

      # Chats
      materialgram
      kdePackages.neochat
      vesktop

      # OBS & plugins
      obs-studio
      obs-studio-plugins.obs-vkcapture
      obs-studio-plugins.input-overlay
      obs-studio-plugins.obs-pipewire-audio-capture

      # Misc
      dconf2nix
      gpick
      gat
    ] ++ lib.optionals wmEnable [
      imagemagick
      grim
      slurp
      wl-clipboard
      wl-screenrec
      vulkan-validation-layers
      wayland
      hyprpicker
      waypaper
      cliphist
      imv
      gtk3
      dbus
      libnotify
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

