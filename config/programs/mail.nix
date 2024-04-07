{ config, username, pkgs, ... }:

{
  sops.secrets."runbox.com/app/pop/password" = {
    owner = "${username}";
  };
  sops.secrets."runbox.com/app/mbsync/password" = {
    owner = "${username}";
  };

  home-manager.users."${username}" = {
    home.packages = with pkgs; [ pop fetchmail_7 ];
    programs.zsh.initExtra = ''
    export POP_SMTP_HOST="mail.runbox.com"
    export POP_SMTP_PORT="587"
    export POP_SMTP_USERNAME="$(cat "${config.sops.secrets."runbox.com/username".path}")"
    export POP_SMTP_PASSWORD="$(cat "${config.sops.secrets."runbox.com/app/pop/password".path}")"
    '';

    programs.mbsync = {
      enable = true;
      accounts = {
        personal = {
          create = true;
          enable = true;
          user = "maxisacat@runbox.com";
          passCmd = "cat ${config.sops.secrets."runbox.com/app/mbsync/password".path}";
          host = "mail.runbox.com";

          Patterns = ["Inbox" "Spam" "Sent" "Trash"];
          # subFolders = "Verbatim";
          path = "~/.mail/";
          inbox = "~/.mail/Inbox";

          channels = {
            sync-personal-inbox = {
              slave = ":personal-local:Inbox";
              master = ":personal-remote:'Inbox'";
            };
            sync-personal-archive = {
              slave = ":personal-local:Spam";
              master = ":personal-remote:'Spam'";
            };
            sync-personal-sent = {
              slave = ":personal-local:Sent";
              master = ":personal-remote:'Sent'";
            };
            sync-personal-trash = {
              slave = ":personal-local:Trash";
              master = ":personal-remote:'Trash'";
            };
          };
          groups = {
            Personal = {
              channels = ["sync-personal-inbox" "sync-personal-spam" "sync-personal-sent" "sync-personal-trash"];
            };
          };
        };
      };
    };
  };

  system.activationScripts.login-to-mbsync.text = ''
  '';
}
