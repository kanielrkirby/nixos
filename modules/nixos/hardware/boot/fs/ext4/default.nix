{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.hardware.boot.fs.ext4;
in {
  options.${namespace}.hardware.boot.fs.ext4 = {
    enable = mkBoolOpt false "Whether or not to enable EXT4.";
  };

  config =
    mkIf cfg.enable {
    };
}
