{ lib
, config
, username
, ...
}:

with lib;

let
  cfg = config.module.user.shellAliases;
in {
  options = {
    module.user.shellAliases.enable = mkEnableOption "Enables ShellAliases for fish/zsh";
  };

  config = mkIf cfg.enable {
    home.shellAliases = {
      "flake-update" = "nix flake update --flake /home/${username}/Code/nixos-configuration/";
      "darwin-update" = "darwin-rebuild switch --flake /Users/${username}/Code/nixos-configuration/";
      "h" = "history";
      "c" = "clear";
      "s" = "sudo su";
      "tree" = "eza --tree -L 3";
      "ls" = "eza";
      "l" = "eza --icons -F -H --group-directories-first --git";
      "ll" = "eza --icons -F -H --group-directories-first --git -all";

      # Git
      "lg" = "lazygit";
      "gs" = "git status";
      "ga" = "git add";
      "ga." = "git add .";
      "gch" = "git checkout";
      "gchb" = "git checkout -b";
      "gc" = "git commit";
      "gcm" = "git commit -m";
      "gb" = "git branch";
      "mergemaster" = "git checkout master; git pull; git merge develop; git push; git checkout develop";
      "gfr" = "git fetch upstream && git rebase upstream/master";

      # Docker
      "di" = "docker images";
      "dr" = "docker run";
      "db" = "docker build";
      "dp" = "docker ps";
      "dps" = "docker ps -a";
      "drmi" = "docker rmi";
      "drm" = "docker rm";

      # Kubernetes
      "k" = "kubectl";

      # Pass
      "passc" = "pass -c";
      "upass" = "pass git pull; pass git push";

      # Others
      "gopenssl" = "/opt/cryptopack3/bin/openssl";
      "fuck" = "_ !!";
      "mkdir" = "mkdir -pv";
      "jctl" = "journalctl -p 3 -xb";
    };
  };
}
