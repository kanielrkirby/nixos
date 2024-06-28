{
  pkgs,
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
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "ga" ''
        if [ -z "$1" ]; then
          git add .
        else
          git add "$@"
        fi
      '')
      (pkgs.writeShellScriptBin "gc" ''
        if [ -z "$1" ]; then
          git commit
        else
          git commit -m "$*"
        fi
      '')
      (pkgs.writeShellScriptBin "gp" ''
        git push "$@"
      '')
      (pkgs.writeShellScriptBin "gac" ''
        ga
        gc "$@"
      '')
      (pkgs.writeShellScriptBin "gcp" ''
        gc "$@"
        gp
      '')
      (pkgs.writeShellScriptBin "gacp" ''
        ga
        gcp "$@"
      '')
      (pkgs.writeShellScriptBin "sga" ''
        if [ -z "$1" ]; then
          sudo -E git add .
        else
          sudo -E git add "$@"
        fi
      '')
      (pkgs.writeShellScriptBin "sgc" ''
        if [ -z "$1" ]; then
          sudo -E git commit
        else
          sudo -E git commit -m "$*"
        fi
      '')
      (pkgs.writeShellScriptBin "sgp" ''
        sudo -E git push "$@"
      '')
      (pkgs.writeShellScriptBin "sgac" ''
        sga
        sgc "$@"
      '')
      (pkgs.writeShellScriptBin "sgcp" ''
        sgc "$@"
        sgp
      '')
      (pkgs.writeShellScriptBin "sgacp" ''
        sga
        sgcp "$@"
      '')
    ];
    home-manager.users.${config.${namespace}.user.name} = {
      programs.git = {
        enable = true;
        delta.enable = true;
        userEmail = "pirate7007@runbox.com";
        userName = "Kaniel Kirby";
        extraConfig.safe.directory = ["/etc/nixos"];
      };
    };
  };
}
