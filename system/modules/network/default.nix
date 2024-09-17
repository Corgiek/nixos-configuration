{ lib
, config
, hostname
, ...
}:

with lib;

let
  cfg = config.module.network;
in {
  options = {
    module.network.enable = mkEnableOption "Enables network";
  };

  config = mkIf cfg.enable {
    systemd.services.NetworkManager-wait-online.enable = false;

    networking = {
      networkmanager = {
        enable = true;
        wifi.macAddress = "random";
        wifi.backend = "iwd";
      };

      wireless.iwd = {
        enable = true;

        settings = {
          Settings = {
            AutoConnect = true;
          };
        };
      };

      useDHCP = mkDefault true;
      hostName = hostname;

      hosts = {
        "0.0.0.0" = [
          "overseauspider.yuanshen.com"
          "log-upload-os.hoyoverse.com"
          "log-upload-os.mihoyo.com"
          "dump.gamesafe.qq.com"

          "log-upload.mihoyo.com"
          "devlog-upload.mihoyo.com"
          "uspider.yuanshen.com"
          "osuspider.yuanshen.com"
          "sg-public-data-api.hoyoverse.com"
          "ys-log-upload-os.hoyoverse.com"
          "public-data-api.mihoyo.com"

          "prd-lender.cdp.internal.unity3d.com"
          "thind-prd-knob.data.ie.unity3d.com"
          "thind-gke-usc.prd.data.corp.unity3d.com"
          "cdp.cloud.unity3d.com"
          "remote-config-proxy-prd.uca.cloud.unity3d.com"  
        ];
      };
    };
  };
}

