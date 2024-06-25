{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.pop;
in {
  options.${namespace}.programs.terminal.tools.pop = {
    enable = mkBoolOpt false "Whether or not to enable pop.";
  };

  config = mkIf cfg.enable {
    sops.secrets = {
      "runbox.com/username" = {
        owner = "${config.${namespace}.user.name}";
      };
      "runbox.com/app/pop/password" = {
        owner = "${config.${namespace}.user.name}";
      };
    };
  };
}
