{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkMerge;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.developer.virtualization.kubernetes;
in {
  options.${namespace}.programs.developer.virtualization.kubernetes = {
    enable = mkBoolOpt false "Whether or not to enable all kubernetes tools.";
    base.enable = mkBoolOpt false "Whether or not to enable kubernetes.";
    kompose.enable = mkBoolOpt false "Whether or not to enable kompose.";
    kubectl.enable = mkBoolOpt false "Whether or not to enable kubectl.";
    minikube.enable = mkBoolOpt false "Whether or not to enable minikube.";
  };

  config = mkMerge [
    (mkIf (cfg.base.enable || cfg.enable) {
      environment.systemPackages = with pkgs; [
        kubernetes
      ];
    })
    (mkIf (cfg.kompose.enable || cfg.enable) {
      environment.systemPackages = with pkgs; [
        kompose
      ];
    })
    (mkIf (cfg.kubectl.enable || cfg.enable) {
      environment.systemPackages = with pkgs; [
        kubectl
      ];
    })
    (mkIf (cfg.minikube.enable || cfg.enable) {
      environment.systemPackages = with pkgs; [
        minikube
      ];
    })
  ];
}
