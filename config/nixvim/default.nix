{ inputs, ... }:

{
  imports = [
    inputs.nixvim.nixosModules.nixvim
    ./misc.nix
    ./git.nix
    ./options.nix
    ./keymaps.nix
    ./treesitter.nix
    ./lang
  ];

  programs.nixvim.enable = true;
}
