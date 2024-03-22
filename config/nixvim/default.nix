{ inputs, ... }:

{
  imports = [
    inputs.nixvim.nixosModules.nixvim
    ./options.nix
    ./keymaps.nix
    ./plugins # default is all
    ./lang # default is all
    ./autocmds.nix
  ];

  programs.nixvim.enable = true;
}
