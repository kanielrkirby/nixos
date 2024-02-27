{ username, pkgs, ... }:

{
  home-manager.users."${username}".home.packages = with pkgs; [
    signal-desktop
    gurk-rs
  ];
}
