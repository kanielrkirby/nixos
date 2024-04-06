{ inputs, username, ... }:

{
  imports = [
    inputs.nixvim.nixosModules.nixvim
    ./options.nix
    ./autocmd.nix
    ./keymaps.nix
    ./plugins # default is all
    ./lang # default is all
  ];

  programs.nixvim.enable = true;
  home-manager.users."${username}" = {
    programs.zsh.initExtra = ''
    export LANG="en_US.UTF-8"
    export LC_ALL="$LANG"
    export EDITOR="nvim"

    alias svim="sudo -E -s nvim"
    '';
  };
}
