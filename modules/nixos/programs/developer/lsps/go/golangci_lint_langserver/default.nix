{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.developer.lsps.go.golangci_lint_langserver;
in {
  options.${namespace}.programs.developer.lsps.go.golangci_lint_langserver = {
    enable = mkBoolOpt false "Whether or not to enable the golangci_lint_langserver.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [golangci-lint-langserver];
  };
}
