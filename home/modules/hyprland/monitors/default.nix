{ config
, lib
, hostname
, ...
}:

with lib;

let
  cfg = config.module.hyprland.monitors;

  monitorsSettings =
    if hostname == "pcbox" then ["HDMI-A-2,1920x1080@72,0x0,1" "DP-3,1024x768@102,1"]
    else if hostname == "nbox" then ["eDP-1,1920x1080@60,0x0,1.25"]
    else [];

  workspacesSettings =
    if hostname == "pcbox" then
      [
        "1, monitor:HDMI-A-1, default:true"
        "2, monitor:HDMI-A-1, default:true"
        "3, monitor:HDMI-A-1, default:true"
        "4, monitor:HDMI-A-1, default:true"
        "5, monitor:HDMI-A-1, default:true"
        "6, monitor:HDMI-A-1, default:true"
        "7, monitor:HDMI-A-1, default:true"
        "8, monitor:HDMI-A-1, default:true"
        "9, monitor:DP-3, default:true"
        "10, monitor:DP-3, default:true"
        "11, monitor:DP-3, default:true"
        "12, monitor:DP-3, default:true"
      ]
    else if hostname == "nbox" then
      [
        "1, monitor:eDP-1, default:true"
        "2, monitor:eDP-1, default:true"
        "3, monitor:eDP-1, default:true"
        "4, monitor:eDP-1, default:true"
        "5, monitor:eDP-1, default:true"
        "6, monitor:eDP-1, default:true"
        # "7, monitor:eDP-1, default:true"
        # "8, monitor:eDP-1, default:true"
        # "9, monitor:eDP-1, default:true"
        # "10, monitor:eDP-1, default:true"
        # "11, monitor:eDP-1, default:true"
        # "12, monitor:eDP-1, default:true"
      ]
    else [];
in {
  options = {
    module.hyprland.monitors.enable = mkEnableOption "Enables monitors in Hyprland";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      monitor = monitorsSettings;
      workspace = workspacesSettings;
    };
  };
}
