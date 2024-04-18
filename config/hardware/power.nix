{ username, pkgs, ... }:

{
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
      USB_AUTOSUSPEND = 0;
    };
  };

  powerManagement.enable = false;

  services.udev.extraRules = ''
  ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="8087", ATTR{idProduct}=="0a2a", ATTR{power/autosuspend}="-1"
  '';

  home-manager.users."${username}".home.packages = with pkgs; [ powertop ];
}
