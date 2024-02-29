{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    where-is-my-sddm-theme
    git
  ];

  fonts.packages = with pkgs.unstable; [
    (nerdfonts.override { fonts = [ "Monaspace" ]; })
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman
      thunar-archive-plugin
    ];
  };

  programs.zsh.enable = true;

  programs.hyprland.enable = true;

#  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
