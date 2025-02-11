{ config
, lib
, hostname
, ...
}:

with lib;

let
  cfg = config.module.sway.outputs;

  outputs = {
    default = {  };

    pcbox = {
      HDMI-A-2 = { 
        resolution = "1920x1080@72Hz";
        position = "0 0";
      };
      
      DP-3 = {
        resolution = "1024x768@102Hz";
        position = "1920 312";
      };
    };

    legioner = {
      eDP-1 = {
        resolution = "1920x1080@60Hz";
        position = "0 0";
      };

      HDMI-A-2 = { 
        resolution = "1920x1080@72Hz";
        position = "1920 312";
      };
    };

    nbox = {
      eDP-1 = {
        resolution = "1920x1080@60Hz";
        position = "0 0";
      };
    };
  };

  workspaces = {
    default = [  ];

    pcbox = [
      { workspace = "1"; output = "HDMI-A-2"; }
      { workspace = "2"; output = "HDMI-A-2"; }
      { workspace = "3"; output = "HDMI-A-2"; }
      { workspace = "4"; output = "HDMI-A-2"; }
      { workspace = "5"; output = "HDMI-A-2"; }
      { workspace = "6"; output = "HDMI-A-2"; }
      { workspace = "7"; output = "HDMI-A-2"; }
      { workspace = "8"; output = "HDMI-A-2"; }
      { workspace = "9"; output = "HDMI-A-2"; }
      { workspace = "10"; output = "DP-3"; }
      { workspace = "11"; output = "DP-3"; }
      { workspace = "12"; output = "DP-3"; }
    ];

    legioner = [
      { workspace = "1"; output = "eDP-1"; }
      { workspace = "2"; output = "eDP-1"; }
      { workspace = "3"; output = "eDP-1"; }
      { workspace = "4"; output = "eDP-1"; }
      { workspace = "5"; output = "eDP-1"; }
      { workspace = "6"; output = "eDP-1"; }
      { workspace = "7"; output = "eDP-1"; }
      { workspace = "8"; output = "eDP-1"; }
      { workspace = "9"; output = "HDMI-A-2"; }
      { workspace = "10"; output = "HDMI-A-2"; }
      { workspace = "11"; output = "HDMI-A-2"; }
      { workspace = "12"; output = "HDMI-A-2"; }
    ];

    nbox = [
      { workspace = "1"; output = "eDP-1"; }
      { workspace = "2"; output = "eDP-1"; }
      { workspace = "3"; output = "eDP-1"; }
      { workspace = "4"; output = "eDP-1"; }
      { workspace = "5"; output = "eDP-1"; }
      { workspace = "6"; output = "eDP-1"; }
    ];
  };
in {
  options.module.sway.outputs = {
    enable = mkEnableOption "Enable sway outputs";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.sway.config = {
      output = outputs.${hostname};

      workspaceOutputAssign = workspaces.${hostname};
    };
  };
}
