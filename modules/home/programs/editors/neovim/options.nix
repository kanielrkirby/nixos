{config, ...}: {
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
      colorcolumn = "";
      linespace = 5;
    };

    globals = let
      t = 0.7;
      p = 2;
    in {
      mapleader = " ";
      neovide_padding_top = p;
      neovide_padding_bottom = p;
      neovide_padding_left = p;
      neovide_padding_right = p;
      transparency = t;
      neovide_transparency = t;
      neovide_scale_factor = 0.75;
      #      netrw_keepdir = 1;
      #      netrw_localcopydircmd = "cp -r";
      #      netrw_banner = 0;
      user_emmet_leader_key = "<C-,>";
    };

    extraConfigLua = ''
      local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
        vim.api.nvim_input('hl')
      end
      vim.keymap.set("n", "<C-=>", function()
        change_scale_factor(1.025)
      end)
      vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1/1.025)
      end)
      vim.api.nvim_set_keymap("v", "<C-S-C>", '"+y', {noremap = true})
      vim.api.nvim_set_keymap("n", "<C-S-C>", '"+yy', {noremap = true})
      vim.api.nvim_set_keymap("i", "<C-S-C>", '<esc>"+yy', {noremap = true})
      vim.api.nvim_set_keymap("", "<C-S-V>", '"+p', {noremap = true})
      vim.api.nvim_set_keymap("i", "<C-S-V>", '<esc>"+pa', {noremap = true})

      vim.cmd([[aunmenu PopUp]])

      -- Normal - Insert
      vim.cmd([[:amenu 90.100 CMenuNormal.Go\ to\ Definition <cmd>:lua vim.lsp.buf.definition()<CR>]])
      vim.cmd([[:amenu 90.100 CMenuNormal.Go\ to\ Type\ Definition <cmd>:lua vim.lsp.buf.type_definition()<CR>]])
      vim.cmd([[:amenu 90.100 CMenuNormal.Go\ to\ Implementations <cmd>:Telescope lsp_implementations<CR>]])
      vim.cmd([[:amenu 90.100 CMenuNormal.Go\ to\ References <cmd>:Telescope lsp_references<CR>]])
      vim.cmd([[:amenu 90.100 CMenuNormal.-1- *]])
      vim.cmd([[:amenu 90.100 CMenuNormal.Rename\ Definition <cmd>:lua vim.lsp.buf.rename()<CR>]])
      vim.cmd([[:amenu 90.100 CMenuNormal.Code\ Actions <cmd>:lua require('telescope').extensions.code_actions.code_actions()<CR>]])
      vim.cmd([[:amenu 90.100 CMenuNormal.-2- *]])

      -- Copy/Cut/Paste
      vim.cmd([[:imenu 90.100 CMenuNormal.Copy <C-S-C>]])
      vim.cmd([[:nmenu 90.100 CMenuNormal.Copy <C-S-C>]])
      vim.cmd([[:imenu 90.100 CMenuNormal.Cut <C-S-X>]])
      vim.cmd([[:nmenu 90.100 CMenuNormal.Cut <C-S-X>]])
      vim.cmd([[:imenu 90.100 CMenuNormal.Paste <C-S-V>]])
      vim.cmd([[:nmenu 90.100 CMenuNormal.Paste <C-S-V>]])

      vim.cmd([[:amenu 90.100 CMenuNormal.-4- *]])
      -- Format Document
      vim.cmd([[:amenu 90.100 CMenuNormal.Format\ Document <cmd>:lua require('conform').format()<CR>]])

      -- Visual
      vim.cmd([[:vmenu 90.110 CMenuVisual.Copy "+y]])
      vim.cmd([[:vmenu 90.110 CMenuVisual.Cut "+x]])
      vim.cmd([[:vmenu 90.110 CMenuVisual.Paste <C-V>]])
      vim.cmd([[:amenu 90.110 CMenuVisual.-1- *]])
      vim.cmd([[:vmenu 90.110 CMenuVisual.Delete "_d]])

      vim.cmd([[:imenu 90.110 CMenuVisual.Copy "+y]])
      vim.cmd([[:imenu 90.110 CMenuVisual.Cut "+x]])
      vim.cmd([[:imenu 90.110 CMenuVisual.Paste <C-V>]])
      vim.cmd([[:imenu 90.110 CMenuVisual.Delete "_dd]])

      vim.keymap.set("n", "<RightMouse>", "<cmd>:popup CMenuNormal<CR>")
      vim.keymap.set("v", "<RightMouse>", "<cmd>:popup CMenuVisual<CR>")
    '';
  };
}
