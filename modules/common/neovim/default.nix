{ config, lib, pkgs, inputs, ... }:

{
  options.gearshift.neovim = {
    enable = lib.mkEnableOption "Neovim configuration";
  };

  imports = [
    inputs.nixvim.nixosModules.nixvim
    ./options.nix
    ./autocmd.nix
    ./keymaps.nix
    ./plugins
    ./lang
  ];

  config = lib.mkMerge [
    (lib.mkIf config.gearshift.neovim.enable {
      programs.nixvim = {
        enable = true;
        package = pkgs.neovim-unwrapped.overrideAttrs (oldAttrs: {
          version = "0.10.0";
          src = pkgs.fetchFromGitHub {
            owner = "neovim";
            repo = "neovim";
            rev = "nightly";
            hash = "sha256-Ml5HzPmVx/fnLedNpBYQs3YG2zhSKsPga89yaCDVYlM=";
          };
        });
      };
      home-manager.users."${config.gearshift.username}" = {
        programs.zsh.initExtra = ''
        export EDITOR="nvim"
        alias svim="sudo -E -s nvim"
        '';
      };
    })
  ];
}
