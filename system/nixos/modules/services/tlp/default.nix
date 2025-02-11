{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.tlp;
in {
  options = {
    module.services.tlp.enable = mkEnableOption "Enable tlp";
  };

  config = mkIf cfg.enable {
    services.tlp = {
      enable = true;
      
      settings = {
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "balanced";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balanced";

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        CPU_HWP_DYN_BOOST_ON_AC=1
        CPU_HWP_DYN_BOOST_ON_BAT=0

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 80;

        WIFI_PWR_ON_AC=off
        WIFI_PWR_ON_BAT=on

        SOUND_POWER_SAVE_ON_AC=0
        SOUND_POWER_SAVE_ON_BAT=1

        NMI_WATCHDOG=0

        MEM_SLEEP_ON_AC=s2idle
        MEM_SLEEP_ON_BAT=deep

        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 95;

        START_CHARGE_THRESH_BAT1 = 40;
        STOP_CHARGE_THRESH_BAT1 = 80;
      };
    };
  };
}

