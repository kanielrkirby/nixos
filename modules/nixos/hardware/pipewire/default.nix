{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.hardware.pipewire;
in {
  options.${namespace}.hardware.pipewire = {
    enable = mkBoolOpt false "Whether or not to enable pipewire.";
  };

  config = mkIf cfg.enable {
    security.rtkit = enabled;
    services.pipewire = {
      enable = true;
      wireplumber = enabled;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse = enabled;
      jack = enabled;
    };
  };
}
