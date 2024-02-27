{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.mail.enable = mkEnableOption "Mail";

  config = mkIf config.gearshift.mail.enable {
    sops.secrets."runbox.com/username" = {
      owner = "${config.gearshift.username}";
    };
    sops.secrets."runbox.com/app/pop/password" = {
      owner = "${config.gearshift.username}";
    };
    sops.secrets."runbox.com/app/mbsync/password" = { };

    home-manager.users."${config.gearshift.username}" = {
      home.packages = with pkgs; [ pop fetchmail_7 isync ];
      programs.zsh.initExtra = ''
      export POP_SMTP_HOST="mail.runbox.com"
      export POP_SMTP_PORT="587"
      export POP_SMTP_USERNAME="$(cat "${config.sops.secrets."runbox.com/username".path}")"
      export POP_SMTP_PASSWORD="$(cat "${config.sops.secrets."runbox.com/app/pop/password".path}")"
      '';
    };

#  system.activationScripts.login-to-mbsync.text = ''
#  source "${config.system.build.setEnvironment}"
#  cat << EOF > /home/mx/.mbsyncrc
#    IMAPAccount Personal
#    Host mail.runbox.com
#    User "$(cat "${config.sops.secrets."runbox.com/username".path}")"
#    Pass "$(cat "${config.sops.secrets."runbox.com/app/mbsync/password".path}")"
#    SSLType IMAPS
#    CertificateFile /etc/ssl/certs/ca-certificates.crt
#
#    IMAPStore personal-remote
#    Account Personal
#
#    MaildirStore personal-local
#    Subfolders Verbatim
#    Path ~/.local/share/mail/
#    Inbox ~/.local/share/mail/Inbox
#
#    Channel sync-personal-inbox
#    Far :personal-remote:"Inbox"
#    Near :personal-local:Inbox
#    Create Near
#    SyncState *
#    CopyArrivalDate yes
#
#    Channel sync-personal-spam
#    Far :personal-remote:"Spam"
#    Near :personal-local:Spam
#    Create Near
#    SyncState *
#    CopyArrivalDate yes
#
#    Channel sync-personal-sent
#    Far :personal-remote:"Sent"
#    Near :personal-local:Sent
#    Create Near
#    SyncState *
#    CopyArrivalDate yes
#
#    Channel sync-personal-trash
#    Far :personal-remote:"Trash"
#    Near :personal-local:Trash
#    Create Near
#    SyncState *
#    CopyArrivalDate yes
#
#    Group Personal
#    Channel sync-personal-inbox
#    Channel sync-personal-spam
#    Channel sync-personal-sent
#    Channel sync-personal-trash
#EOF
#  '';
  };
}
