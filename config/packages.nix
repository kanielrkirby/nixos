{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ git ];

  fonts.packages = with pkgs.unstable;
    [ (nerdfonts.override { fonts = [ "Monaspace" ]; }) ];

  programs = {
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar-volman thunar-archive-plugin ];
    };

    zsh.enable = true;

    hyprland.enable = true;
  };

  #  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
