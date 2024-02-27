{ pkgs, username, ... }:

{
  home-manager.users."${username}".home.packages = with pkgs; [
    kubernetes
    kompose
    kubectl
    minikube
  ];
}
