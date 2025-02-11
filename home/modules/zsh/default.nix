{ inputs
, lib
, config
, homeModules
, ...
}:

with lib;

let
  cfg = config.module.zsh;
in {
  options = {
    module.zsh.enable = mkEnableOption "Enables zsh";
  };

  config = mkIf cfg.enable {
    home.file.".p10k.zsh".source = "${homeModules}/zsh/p10k.zsh";
    home.file.".helmrc".source = "${homeModules}/zsh/helmrc";

    programs.zsh = {
      enable = true;

      plugins = with inputs; [
        {
          name = "powerlevel10k";
          file = "powerlevel9k.zsh-theme";
          src = powerlevel10k;
        }
        {
          name = "zsh-autosuggestions";
          file = "zsh-autosuggestions.plugin.zsh";
          src = zsh-autosuggestions;
        }
        {
          name = "zsh-history-substring-search";
          file = "zsh-history-substring-search.plugin.zsh";
          src = zsh-syntax-highlighting;
        }
        {
          name = "zsh-syntax-highlighting";
          file = "zsh-syntax-highlighting.plugin.zsh";
          src = zsh-syntax-highlighting;
        }
        {
          name = "zsh-auto-notify";
          file = "zsh-auto-notify.plugin.zsh";
          src = zsh-auto-notify;
        }
      ];

      oh-my-zsh = {
        enable = true;

        plugins = [
          "git"
          "vagrant"
          "docker"
          "python"
          "pass"
          "kubectl"
        ];

        extraConfig = ''
          zstyle ':omz:update' mode disabled
        '';
      };

      initExtraFirst = ''
        ${inputs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
      '';

      initExtra = ''
        POWERLEVEL9K_MODE="nerdfont-complete"
        export PATH=$PATH:$ANDROID_HOME/tools
        export PATH=$PATH:$ANDROID_HOME/tools/bin
        export PATH=$PATH/:$ANDROID_HOME/platform-tools
        export GPG_TTY=$TTY

        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
        [[ ! -f ~/.helmrc ]] || source ~/.helmrc
      '';
    };
  };
}

