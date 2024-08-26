{ config
, lib
, username
, ...
}:

with lib;

let
  cfg = config.module.xdg;
in {
  options = {
    module.xdg.enable = mkEnableOption "Enables xdg";
  };

  config = mkIf cfg.enable {
    xdg.mimeApps = {
      enable = true;

      defaultApplications = {
        "text/markdown" = "nvim.desktop";
        "text/plain" = "nvim.desktop";

        "text/html" = "floorp.desktop";
        "x-scheme-handler/http" = "floorp.desktop";
        "x-scheme-handler/https" = "floorp.desktop";
        "x-scheme-handler/about" = "floorp.desktop";
        "x-scheme-handler/unknown" = "floorp.desktop";

        "image/png" = "org.gnome.eog.desktop";
        "image/jpeg" = "org.gnome.eog.desktop";
        "image/jpg" = "org.gnome.eog.desktop";

        "application/pdf" = "org.pwmt.zathura.desktop";

        "inode/directory" =  "yazi";
      };
    };

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      music = "/home/${username}/Music";
      pictures = "/home/${username}/Pictures";
      desktop = "/home/${username}/Desktop";
      templates = null;
    };
  };
}

