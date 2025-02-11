{ lib
, config
, username
, ...
}:

with lib;

let
  cfg = config.module.user.variables;
in {
  options = {
    module.user.variables.enable = mkEnableOption "Enables user variables";
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      QT_QPA_PLATFORM                           = "wayland:xcb";
      QT_QPA_PLATFORMTHEME                      = "gtk3";
      DISABLE_QT5_COMPAT                        = "0";
      SDL_VIDEODRIVER                           = "wayland";
      CLUTTER_BACKEND                           = "wayland";
      GDK_BACKEND                               = "wayland";
      MOZ_ENABLE_WAYLAND                        = "1";
      MOZ_LEGACY_PROFILES                       = "1";
      XDG_SESSION_TYPE                          = "wayland";
      NIXOS_OZONE_WL                            = "1";
      FLAKE                                     = "/home/${username}/Code/nixos-configuration";
      TDESKTOP_I_KNOW_ABOUT_GTK_INCOMPATIBILITY = "1";
    };
  };
}

