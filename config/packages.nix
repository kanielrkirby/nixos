{ pkgs, environment, ... }:

{
  environment.systemPackages = with pkgs; [
    where-is-my-sddm-theme
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
}
