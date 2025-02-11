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
    systemd = {
      network.enable = true;

      services = {
        NetworkManager-wait-online.enable = false;
        systemd-networkd-wait-online.enable = mkForce false;
      };
    };   

    boot.kernel.sysctl = {
        # TCP optimization
        # TCP Fast Open is a TCP extension that reduces network latency by packing
        # data in the sender’s initial TCP SYN. Setting 3 = enable TCP Fast Open for
        # both incoming and outgoing connections:
        "net.ipv4.tcp_fastopen" = 3;
        # Bufferbloat mitigations + slight improvement in throughput & latency
        "net.ipv4.tcp_congestion_control" = "bbr";
        "net.core.default_qdisc" = "cake";

        "net.core.optmem_max" = 65536;
        "net.core.rmem_default" = 1048576;
        "net.core.rmem_max" = 16777216;
        "net.core.somaxconn" = 8192;
        "net.core.wmem_default" = 1048576;
        "net.core.wmem_max" = 16777216;
        "net.ipv4.ip_local_port_range" = "16384 65535";
        "net.ipv4.tcp_max_syn_backlog" = 8192;
        "net.ipv4.tcp_max_tw_buckets" = 2000000;
        "net.ipv4.tcp_mtu_probing" = 1;
        "net.ipv4.tcp_rmem" = "4096 1048576 2097152";
        "net.ipv4.tcp_slow_start_after_idle" = 0;
        "net.ipv4.tcp_tw_reuse" = 1;
        "net.ipv4.tcp_wmem" = "4096 65536 16777216";
        "net.ipv4.udp_rmem_min" = 8192;
        "net.ipv4.udp_wmem_min" = 8192;
        "net.netfilter.nf_conntrack_generic_timeout" = 60;
        "net.netfilter.nf_conntrack_max" = 1048576;
        "net.netfilter.nf_conntrack_tcp_timeout_established" = 600;
        "net.netfilter.nf_conntrack_tcp_timeout_time_wait" = 1;
    };

    networking = {
      firewall = {
        enable = true;
      };

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

