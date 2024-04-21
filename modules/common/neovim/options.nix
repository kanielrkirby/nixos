{ config, ... }:

{
  programs.nixvim = {
    opts = {
      foldenable = false;
      nu = true;
      relativenumber = true;
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      smartindent = true;
      wrap = false;
      swapfile = false;
      backup = false;
      undofile = true;
      undodir = "/home/${config.gearshift.username}/.config/nvim/undodir";
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      signcolumn = "yes";
      updatetime = 50;
      colorcolumn = "80";
    };

    globals = {
      mapleader = " ";
#      netrw_keepdir = 1;
#      netrw_localcopydircmd = "cp -r";
#      netrw_banner = 0;
      user_emmet_leader_key = "<C-,>";
    };
  };
}
