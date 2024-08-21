{ lib
, config
, username
, ...
}:

with lib;

let
  cfg = config.module.impermanence;  
in {
  options = {
    module.impermanence.enable = mkEnableOption "Enables home impermanence";
  };

  config = mkIf cfg.enable {
    home.persistence = {
      "/persist/home/${username}" = {
        allowOther = true;

        directories = [
          "Code"
          "Downloads"
          "Documents"
          "go"
          "Music"
          "Pictures"
          "Videos"
          "Trash"
          "Sync"
          ".ansible_inventory"
          ".docker"
          ".emacs.d"
          ".flutter-devtools"
          ".kube"
          ".mozilla"
          ".thunderbird"
          ".obsidian"
          ".openvpn"
          ".password-store"
          ".themes"
          ".terraform.d"
          ".ollama"
          ".config/google-chrome"
          ".config/sops"
          ".config/vesktop"
          ".config/sops-nix"
          ".config/obsidian"
          ".config/Code"
          ".config/dconf"
          ".config/htop"
          ".config/nvim"
          ".config/syncthing"
          ".config/pulse"
          ".local/share/zoxide"
          ".local/share/fish"
          ".local/share/nix"
          ".local/share/containers"
          ".local/share/Trash"
          ".local/share/TelegramDesktop"
          ".local/share/keyrings"
          ".local/share/nvim"
          ".local/share/PrismLauncher"
          ".local/state"
          ".vscode"
          ".pki"
          ".ssh"
          ".gnupg"
        ];

        files = [
          ".zsh_history"
          ".cache/cliphist/db"
        ];
      };
    };
  };
}

