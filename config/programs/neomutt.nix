{ config, pkgs, username, ... }:

{
  sops.secrets."runbox/app/neomutt/password" = { };

  home-manager.users."${username}".programs.neomutt = {
    enable = true;

    vimKeys = true;

    # Basic account settings
    extraConfig = ''
      set smtp_url = "smtp://maxisacat@runbox.com:465/"
      set smtp_pass = "`cat '${
        config.sops.secrets."runbox/app/neomutt/password".path
      }'`"
      set from = "maxisacat@runbox.com"
      set realname = "Kaniel Kirby"

      set imap_url = "imaps://mail.runbox.com:993/"
      set imap_pass = "`cat '${
        config.sops.secrets."runbox/app/neomutt/password".path
      }'`"

      set folder = "imaps://mail.runbox.com/"
      set spoolfile = "+INBOX"
      set postponed = "+Drafts"
      set trash = "+Trash"
      set realname = "Kaniel Kirby"
      set ssl_force_tls = yes
    '';
  };
}
