{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.git;
in {
  options.${namespace}.programs.terminal.tools.git = {
    enable = mkBoolOpt false "Whether or not to enable git.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    home-manager.users.${config.${namespace}.user.name}.programs.git = {
      enable = true;
      delta.enable = true;
      userEmail = "pirate7007@runbox.com";
      userName = "Kaniel Kirby";
      extraConfig.safe.directory = ["/etc/nixos"];
      zsh.initExtra = ''
        alias ga='if [ -z "$@" ]; then git add .; else git add "$@"; fi'
        alias gc='if [ -z "$@" ]; then git commit; else git commit -m "$@"; fi'
        alias gp='git push "$@";'
        alias gac='if [ -z "$@" ]; then git add . && git commit && git push; else git add . && git commit -m "$@"; fi'
        alias gacp='if [ -z "$@" ]; then git add . && git commit && git push; else git add . && git commit -m "$@" && git push; fi'
        alias gcp='if [ -z "$@" ]; then git commit && git push; else git commit -m "$@" && git push; fi'

        alias sga='if [ -z "$@" ]; then sudo -E git add .; else sudo -E git add "$@"; fi'
        alias sgc='if [ -z "$@" ]; then sudo -E git commit; else sudo -E git commit -m "$@"; fi'
        alias sgp='sudo -E git push "$@";'
        alias sgac='if [ -z "$@" ]; then sudo -E git add . && sudo -E git commit && sudo -E git push; else sudo -E git add . && sudo -E git commit -m "$@"; fi'
        alias sgacp='if [ -z "$@" ]; then sudo -E git add . && sudo -E git commit && sudo -E git push; else sudo -E git add . && sudo -E git commit -m "$@" && sudo -E git push; fi'
        alias sgcp='if [ -z "$@" ]; then sudo -E git commit && sudo -E git push; else sudo -E git commit -m "$@" && sudo -E git push; fi'
      '';
    };
  };
}
