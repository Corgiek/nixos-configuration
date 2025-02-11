{ inputs
, lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.nix-config;
in {
  options = {
    module.nix-config = {
      enable = mkEnableOption "Enables nix-config";

      useNixPackageManagerConfig = mkOption {
        type = types.bool;
        description = "Whether to use custom Nix package manager settings.";
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    # Nixpkgs config
    nixpkgs.config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;

      permittedInsecurePackages = [
        "electron-27.3.11"
        "electron-25.9.0"
        "electron-19.1.9"
        "olm-3.2.16"
      ];
    };

    # Nix package manager settings
    nix = {
      package = pkgs.lix;
      registry.s.flake = inputs.self;

      settings = {
        # automatically optimise symlinks
        auto-optimise-store = pkgs.stdenv.hostPlatform.isLinux;
        use-cgroups = true;

        # this defaults to true, however it slows down evaluation so maybe we should disable it
        # some day, but we do need it for catppuccin/nix so maybe not too soon
        allow-import-from-derivation = true;

        # don't warn me if the current working tree is dirty
        # i don't need the warning because i'm working on it right now
        warn-dirty = false;

        # use xdg base directories for all the nix things
        use-xdg-base-directories = true;

        # continue building derivations even if one fails
        # this is important for keeping a nice cache of derivations, usually because I walk away
        # from my PC when building and it would be annoying to deal with nothing saved
        keep-going = true;

        # show more log lines for failed builds, as this happens alot and is useful
        log-lines = 30;

        # let the system decide the number of max jobs
        max-jobs = "auto";

        # build inside sandboxed environments
        # we only enable this on linux because it servirly breaks on darwin
        sandbox = pkgs.stdenv.hostPlatform.isLinux;

        # supported system features
        system-features = [
          "nixos-test"
          "kvm"
          "recursive-nix"
          "big-parallel"
        ];

        extra-experimental-features = [
          "nix-command"
          "flakes"
          "cgroups"
          "auto-allocate-uids"
          "dynamic-derivations"
          "repl-flake"
        ];

        substituters = [
          "https://hyprland.cachix.org"
          "https://nyx.chaotic.cx"
          "https://ghostty.cachix.org"
          "https://cache.saumon.network/proxmox-nixos"
        ];

        trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
          "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
          "proxmox-nixos:nveXDuVVhFDRFx8Dn19f1WDEaNRJjPrF2CPD2D+m1ys="
        ];
      };

      gc = {
        automatic = true;
        options = "--delete-older-than 7d";
      };
    };
  };
}
