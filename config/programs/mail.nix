{ config, username, pkgs, ... }:

{
  sops.secrets."runbox.com" = { };

  home-manager.users."${username}" = {
    home.packages = with pkgs; [ pop ];
    programs.zsh.initExtra = ''
    export POP_SMTP_HOST="mail.runbox.com"
    export POP_SMTP_PORT="587"
    export POP_SMTP_USERNAME="maxisacat@runbox.com"
    export POP_SMTP_PASSWORD="$(cat ${config.sops.secrets."runbox.com".path})"
    '';
  };
}
