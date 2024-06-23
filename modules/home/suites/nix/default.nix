{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.nix;
in {
  options.${namespace}.nix = {
    enable = mkBoolOpt false "Whether or not to enable nh.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      nix.defaultSettings = enabled;
      programs.nix = {
        comma = enabled;
        nd = enabled;
        nh = enabled;
        ns = enabled;
        up = enabled;
      };
    };
  };
}
