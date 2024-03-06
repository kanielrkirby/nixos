{
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>pv";
      action = "<cmd>Oil<CR>";
    }
    {
      mode = "v";
      key = "J";
      action = ":m '>+1<CR>gv=gv";
    }
    {
      mode = "v";
      key = "K";
      action = ":m '<-2<CR>gv=gv";
    }
    {
      mode = "n";
      key = "J";
      action = "mzJ`z";
    }
    {
      mode = "n";
      key = "<C-d>";
      action = "<C-d>zz";
    }
    {
      mode = "n";
      key = "<C-u>";
      action = "<C-u>zz";
    }
    {
      mode = "n";
      key = "n";
      action = "nzzzv";
    }
    {
      mode = "n";
      key = "N";
      action = "Nzzzv";
    }
    {
      mode = "x";
      key = "<leader>p";
      action = ''"_dP'';
    }
    {
      mode = "n";
      key = "<leader>y";
      action = ''"+y'';
    }
    {
      mode = "v";
      key = "<leader>y";
      action = ''"+y'';
    }
    {
      mode = "n";
      key = "<leader>Y";
      action = ''"+Y'';
    }
    {
      mode = "n";
      key = "<leader>d";
      action = ''"+d'';
    }
    {
      mode = "v";
      key = "<leader>d";
      action = ''"+d'';
    }
    {
      mode = "n";
      key = "<leader>D";
      action = ''"+D'';
    }
    {
      mode = "i";
      key = "<C-c>";
      action = "<Esc>";
    }
    {
      mode = "n";
      key = "Q";
      action = "<nop>";
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<cmd>cprev<CR>zz";
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<cmd>cnext<CR>zz";
    }
    {
      mode = "n";
      key = "<leader>k";
      action = "<cmd>cprev<CR>zz";
    }
    {
      mode = "n";
      key = "<leader>j";
      action = "<cmd>cnext<CR>zz";
    }
    {
      mode = "n";
      key = "<leader>s";
      action = "[[:%s/<<C-r><C-w>>/<C-r><C-w>/gI<Left><Left><Left>]]";
    }
    {
      mode = "n";
      key = "<leader>S";
      action = "[[:%s/<<C-r><C-w>>//gI<Left><Left><Left>]]";
    }
    {
      mode = "n";
      key = "<A-h>";
      action = "<C-w>h";
    }
    {
      mode = "n";
      key = "<A-j>";
      action = "<C-w>j";
    }
    {
      mode = "n";
      key = "<A-k>";
      action = "<C-w>k";
    }
    {
      mode = "n";
      key = "<A-l>";
      action = "<C-w>l";
    }
    {
      mode = "i";
      key = "<A-h>";
      action = "<C-w>h";
    }
    {
      mode = "i";
      key = "<A-j>";
      action = "<C-w>j";
    }
    {
      mode = "i";
      key = "<A-k>";
      action = "<C-w>k";
    }
    {
      mode = "i";
      key = "<A-l>";
      action = "<C-w>l";
    }
    {
      mode = "t";
      key = "<A-h>";
      action = "<C-\\><C-n><C-w>h";
    }
    {
      mode = "t";
      key = "<A-j>";
      action = "<C-\\><C-n><C-w>j";
    }
    {
      mode = "t";
      key = "<A-k>";
      action = "<C-\\><C-n><C-w>k";
    }
    {
      mode = "t";
      key = "<A-l>";
      action = "<C-\\><C-n><C-w>l";
    }
    {
      mode = "n";
      key = "<C-w>en";
      action = "<cmd>split term://zsh<CR>";
    }
    {
      mode = "n";
      key = "<C-w>ev";
      action = "<cmd>vsplit term://zsh<CR>";
    }
    {
      mode = "n";
      key = "<leader>f";
      lua = true;
      action = ''
        function (args)
            require("conform").format()
        end
      '';
    }
    {
      mode = "n";
      key = "<leader>u";
      action = "<cmd>UndotreeToggle<CR>";
    }
    {
      mode = "n";
      key = "<C-h>";
      action = "require('harpoon-ui').nav_file(1)";
    }
    {
      mode = "n";
      key = "<C-t>";
      action = "require('harpoon-ui').nav_file(2)";
    }
    {
      mode = "n";
      key = "<C-n>";
      action = "require('harpoon-ui').nav_file(3)";
    }
    {
      mode = "n";
      key = "<C-s>";
      action = "require('harpoon-ui').nav_file(4)";
    }
  ];
}

