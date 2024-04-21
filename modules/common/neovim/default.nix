{ config, lib, pkgs, inputs, ... }:

with lib;
{
  options.gearshift.neovim = {
    enable = mkEnableOption "Neovim configuration";
  };

  imports = [
    inputs.nixvim.nixosModules.nixvim
    ./options.nix
    ./autocmd.nix
    ./keymaps.nix
    ./plugins
    ./lang
  ];

  config = mkMerge [
    (mkIf config.gearshift.neovim.enable {
      programs.nixvim.enable = true;
      home-manager.users."${config.gearshift.username}" = {
        programs.zsh.initExtra = ''
        export EDITOR="nvim"
        alias svim="sudo -E -s nvim"
        '';
      };
    })
  ];
}
