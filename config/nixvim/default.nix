{ inputs, username, ... }:

{
  imports = [
    inputs.nixvim.nixosModules.nixvim
    ./options.nix
    ./autocmd.nix
    ./keymaps.nix
    ./plugins
    ./lang
  ];

  programs.nixvim.enable = true;
  home-manager.users."${username}" = {
    programs.zsh.initExtra = ''
    export EDITOR="nvim"
    alias svim="sudo -E -s nvim"
    '';
  };
}
