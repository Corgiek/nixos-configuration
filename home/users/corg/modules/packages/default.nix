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
    enable = mkEnableOption "Enable maxmur packages";
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

      # Security
      semgrep
      grype
      syft

      # Fonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" "UbuntuMono" "Iosevka" ]; })
      corefonts
    ] ++ lib.optionals (isLinux && isWorkstation) [
      # Programming
      go
      python3

      # DevOps Utils
      docker-compose
      kubectl
      kubernetes-helm
      ansible
      ansible-lint
      terraform
      vagrant

      # Chats
      materialgram
      vesktop

      # Wine
      wineWow64Packages.unstableFull
      lutris

      # OBS & plugins
      obs-studio
      obs-studio-plugins.obs-vkcapture
      obs-studio-plugins.input-overlay
      obs-studio-plugins.obs-pipewire-audio-capture

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

