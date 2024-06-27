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
ga() {
  if [ -z "$1" ]; then
    git add .
  else
    git add "$@"
  fi
}

gc() {
  if [ -z "$1" ]; then
    git commit
  else
    git commit -m "$*"
  fi
}

gp() {
  git push "$@"
}

gac() {
  ga
  gc "$@"
}

gcp() {
  gc "$@"
  gp
}

gacp() {
  ga
  gcp "$@"
}

sga() {
  sudo -E ga "$@"
}

sgc() {
  sudo -E gc "$@"
}

sgp() {
  sudo -E gp "$@"
}

sgac() {
  sga
  sgc "$@"
}

sgcp() {
  sgc "$@"
  sgp
}

sgacp() {
  sga
  sgcp "$@"
}
      '';
    };
  };
}
