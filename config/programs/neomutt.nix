{ config, pkgs, username, ... }:

{
  home-manager.users."${username}".home.programs.neomutt = {
    enable = true;

    vimKeys = true;

    # Basic account settings
    extraConfig = ''
      set smtp_url = "smtp://maxisacat@runbox.com:465/"
      set smtp_pass = "`cat '${config.sops.secrets."runbox/app/neomutt/password".path}'`"
      set from = "maxisacat@runbox.com"
      set realname = "Kaniel Kirby"
      
      set folder = "imaps://mail.runbox.com/"
      set spoolfile = "+INBOX"
      set postponed = "+Drafts"
      set trash = "+Trash"
      set realname = "Kaniel Kirby"
      set ssl_force_tls = yes
    '';

    # IMAP settings
    imap = {
      user = "maxisacat@runbox.com";
      pass = "`cat '${config.sops.secrets."runbox.com/app/neomutt/password".path}'`";
      folder = "imaps://mail.runbox.com:993/";
    };

    # Default mailbox
    spoolfile = "+INBOX";
    postponed = "+Drafts";

    # Sending mail configuration
    sendmailCommand = "msmtp --account=default -t";

    # UI settings
    binds = [
      { key = "c"; map = "index,pager"; action = "change-folder"; }
      # Additional key bindings can be added here
    ];

    # Sorting and display settings
    settings = {
      sort = "threads";
      sort_aux = "reverse-last-date-received";
      index_format = "%4C %Z %{%b %d} %-15.15L (%4c) %s";
    };

    # Alias settings
    aliases = [
    ];

    # PGP and MIME settings (if needed)
    # pgp = { ... };
    # mime = { ... };
  };
}
