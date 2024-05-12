{ config, lib, ... }:

{
  options.gearshift.suite.home = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.gearshift.suite.home.enable {
      gearshift = {
        brightnessctl.enable = true;
        foliate.enable = true;
        dunst.enable = true;
        grim.enable = true;
        fw-ectool.enable = true;
        libnotify.enable = true;
        nom.enable = true;
        playerctl.enable = true;
        slurp.enable = true;
        waybar.enable = true;
        wf-recorder.enable = true;
        wl-clipboard.enable = true;
        youtube-tui.enable = true;
        browser.brave.enable = true;
        localsend.enable = true;
        mail.enable = true;
        mpv.enable = true;
        signal.enable = true;
        smassh.enable = true;
        thunar.enable = true;
        transmission.enable = true;
        fuzzel.enable = true;
        warpd.enable = true;
        ydotool.enable = true;
      };
    })
  ];
}
