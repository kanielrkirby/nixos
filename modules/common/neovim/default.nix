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
  ];

  config = lib.mkMerge [
    (lib.mkIf config.gearshift.neovim.enable {
      environment.systemPackages = with pkgs; [ neovide ];

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
        xdg.configFile."neovide/config.toml".text = ''
          [font]
          normal = "MonaspiceNe NF"
          italic = "MonaspiceRn NF"
          size = 14
        '';
        programs.zsh.initExtra = ''
        export EDITOR="neovide --no-fork"
        alias svim="sudo -E neovide"
        '';
      };
    })
  ];
}
