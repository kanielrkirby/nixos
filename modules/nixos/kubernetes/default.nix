{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift = {
    k8s.enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.k8s.enable {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [
        kubernetes
        kompose
        kubectl
        minikube
      ];
    })
  ];
}
