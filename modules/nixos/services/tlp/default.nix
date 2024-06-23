{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.services.tlp;
in {
  options.${namespace}.services.tlp = {
    enable = mkBoolOpt false "Whether or not to enable tlp.";
  };

  config = mkIf cfg.enable {
    services.tlp = {
      enable = true;
      settings = {
        # CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_SCALING_GOVERNOR_ON_BAT = "performance";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
  
        # CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "performance";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
  
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;
  
        START_CHARGE_THRESH_BAT1 = 40;
        STOP_CHARGE_THRESH_BAT1 = 80;
      };
    };
  
    powerManagement.enable = false;
  };
}
