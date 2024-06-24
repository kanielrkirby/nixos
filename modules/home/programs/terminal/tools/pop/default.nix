{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.pop;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [pop];
    programs.zsh.initExtra = ''
      export POP_SMTP_HOST="mail.runbox.com"
      export POP_SMTP_PORT="587"
      export POP_SMTP_USERNAME="$(cat "${config.sops.secrets."runbox.com/username".path}")"
      export POP_SMTP_PASSWORD="$(cat "${config.sops.secrets."runbox.com/app/pop/password".path}")"
    '';
  };
}

