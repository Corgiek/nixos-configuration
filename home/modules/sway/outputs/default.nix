{ config
, lib
, hostname
, ...
}:

with lib;

let
  cfg = config.module.sway.outputs;

  pcboxOutputs = {
    HDMI-A-2 = { 
      resolution = "1920x1080@72Hz";
      position = "0 0";
      adaptive_sync = "on";
    };
    
    DP-3 = {
      resolution = "1024x768@102Hz";
      position = "1920 312";
    };
  };

  nboxOutputs = {
    eDP-1 = {
      resolution = "1920x1080@60Hz";
      position = "0 0";
    };
  };

  outputsByHostname = if hostname == "pcbox"
    then pcboxOutputs
  else if hostname == "nbox"
    then nboxOutputs
  else {};

  pcboxWorkspaces = [
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

  nboxWorkspaces = [
    { workspace = "1"; output = "eDP-1"; }
    { workspace = "2"; output = "eDP-1"; }
    { workspace = "3"; output = "eDP-1"; }
    { workspace = "4"; output = "eDP-1"; }
    { workspace = "5"; output = "eDP-1"; }
    { workspace = "6"; output = "eDP-1"; }
  ];

  workspacesByHostname = if hostname == "pcbox"
    then pcboxWorkspaces
  else if hostname == "nbox"
    then nboxWorkspaces
  else [];
in {
  options.module.sway.outputs = {
    enable = mkEnableOption "Enable sway outputs";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.sway.config = {
      output = outputsByHostname;

      workspaceOutputAssign = workspacesByHostname;
    };
  };
}

