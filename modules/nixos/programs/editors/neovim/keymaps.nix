{
  programs.nixvim.keymaps = [
    # Move lines
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

    # Flatten
    {
      mode = "n";
      key = "J";
      action = "mzJ`z";
    }

    # Scrolling
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

    # Next / Prev
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

    # I don't know
    {
      mode = "x";
      key = "<leader>p";
      action = ''"_dP'';
    }

    # Clipboard
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

    # Escape
    {
      mode = "i";
      key = "<C-c>";
      action = "<Esc>";
    }

    # Unbind Q
    {
      mode = "n";
      key = "Q";
      action = "<nop>";
    }

    # LSP Diagnostics
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

    # Find / Replace
    {
      mode = "n";
      key = "<leader>s";
      action = ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>";
    }
    {
      mode = "n";
      key = "<leader>S";
      action = ":%s/\\<<C-r><C-w>>\\//gI<Left><Left><Left>";
    }

    # Vim Window Bindings
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
      mode = "c";
      key = "<C-S-V>";
      action = ''<C-r>+'';
    }
    {
      mode = [
        "v"
        "n"
        "t"
        "i"
      ];
      key = "<C-S-V>";
      action = ''"+p'';
    }
  ];
}
