{ lib
, config
, username
, ...
}:

with lib;

let
  cfg = config.module.user.impermanence;  
in {
  options = {
    module.user.impermanence.enable = mkEnableOption "Enables home impermanence";
  };

  config = mkIf cfg.enable {
    home.persistence = {
      "/persist/home/${username}" = {
        allowOther = true;

        directories = [
          "Code"
          "Desktop"
          "Games"
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
          ".kube"
          ".m2"
          ".mozilla"
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
          ".local/share/zoxide"
          ".local/share/fish"
          ".local/share/nix"
          ".local/share/containers"
          ".local/share/Trash"
          ".local/share/TelegramDesktop"
          ".local/share/keyrings"
          ".local/share/nvim"
          ".local/state"
          ".vscode"
          ".pki"
          ".ssh"
          ".gnupg"
        ];

        files = [
          ".face"
          ".face.icon"
          ".zsh_history"
          ".cache/cliphist/db"
        ];
      };
    };
  };
}

