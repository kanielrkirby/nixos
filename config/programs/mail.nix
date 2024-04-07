{ config, username, pkgs, ... }:

{
  sops.secrets."runbox.com/username" = { };
  sops.secrets."runbox.com/app/pop/password" = { };
  sops.secrets."runbox.com/app/mbsync/password" = { };

  home-manager.users."${username}" = {
    home.packages = with pkgs; [ pop fetchmail_7 isync ];
    programs.zsh.initExtra = ''
    export POP_SMTP_HOST="mail.runbox.com"
    export POP_SMTP_PORT="587"
    export POP_SMTP_USERNAME="$(cat "${config.sops.secrets."runbox.com/username".path}")"
    export POP_SMTP_PASSWORD="$(cat "${config.sops.secrets."runbox.com/app/pop/password".path}")"
    '';
  };

  system.activationScripts.login-to-mbsync.text = ''
  source "${config.system.build.setEnvironment}"
  cat << EOF > /home/mx/.mbsyncrc
    IMAPAccount personal
    Host mail.runbox.com
    User "$(cat "${config.sops.secrets."runbox.com/username".path}")"
    Pass "$(cat "${config.sops.secrets."runbox.com/app/mbsync/password".path}")"
    SSLType IMAPS
    CertificateFile /etc/ssl/certs/ca-certificates.crt

    IMAPStore personal-remote
    Account Personal

    MaildirStore personal-local
    Subfolders Verbatim
    Path ~/.config/mail/
    Inbox ~/.config/mail/Inbox

    Channel sync-personal-inbox
    Master :personal-remote:"Inbox"
    Slave :personal-local:Inbox
    Create Slave
    SyncState *
    CopyArrivalDate yes

    Channel sync-personal-spam
    Master :personal-remote:"Spam"
    Slave :personal-local:Spam
    Create Slave
    SyncState *
    CopyArrivalDate yes

    Channel sync-personal-sent
    Master :personal-remote:"Sent"
    Slave :personal-local:Sent
    Create Slave
    SyncState *
    CopyArrivalDate yes

    Channel sync-personal-trash
    Master :personal-remote:"Trash"
    Slave :personal-local:Trash
    Create Slave
    SyncState *
    CopyArrivalDate yes

    Group Personal
    Channel sync-personal-inbox
    Channel sync-personal-spam
    Channel sync-personal-sent
    Channel sync-personal-trash
  EOF
  '';
}
