{ pkgs, ... }:

{
    sound.enable = true;
    # hardware.pulseaudio.enable = true;

    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        mesa
        intel-media-driver
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
}
