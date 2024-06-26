{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkMerge;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.pop;
in {
  options.${namespace}.programs.terminal.tools.pop = {
    enable = mkBoolOpt false "Whether or not to enable pop.";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      environment.systemPackages = with pkgs; [pop];
    })    
    (mkIf (cfg.enable && config.${namespace}.user.enable) {
      sops.secrets = {
        "runbox.com/username" = {
          owner = "${config.${namespace}.user.name}";
        };
        "runbox.com/app/pop/password" = {
          owner = "${config.${namespace}.user.name}";
        };
      };

      home-manager.users.${config.${namespace}.user.name}.programs.zsh.initExtra = ''
        export POP_SMTP_HOST="mail.runbox.com"
        export POP_SMTP_PORT="587"
        export POP_SMTP_USERNAME="$(cat "${config.sops.secrets."runbox.com/username".path}")"
        export POP_SMTP_PASSWORD="$(cat "${config.sops.secrets."runbox.com/app/pop/password".path}")"
      '';
    })    
  ];
}

