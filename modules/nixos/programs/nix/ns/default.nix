{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.nix.ns;
in {
  options.${namespace}.programs.nix.ns = {
    enable = mkBoolOpt false "Whether or not to enable ns.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (writeShellScriptBin "ns" ''
        pkgs=();
        while [[ "$1" != "--" && -n "$1" ]]; do
          pkgs+=("nixpkgs#$1");
          shift;
        done;
        shift;
        cmd=();
        if [[ -n $@ ]]; then
          cmd=("--command" "''${@:-''${pkgs[0]#nixpkgs#}}");
        fi
        nix shell "''${pkgs[@]}" ''${cmd[@]};
      '')
    ];
  };
}
