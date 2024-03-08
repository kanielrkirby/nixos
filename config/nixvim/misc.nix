{ pkgs, ... }:

{
  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
    };

    clipboard = {
      providers.wl-copy.enable = true;
      register = "unnamedplus";
    };

    plugins = {
      harpoon = {
        enable = true;
        enableTelescope = true;
        keymaps = {
          addFile = "<C-a>";
          toggleQuickMenu = "<C-e>";
        };
      };

      treesitter.enable = true;

      ts-autotag.enable = true;
      
      nvim-autopairs.enable = true;
      
      lsp = {
        enable = true;
        keymaps = {
          silent = true;
          lspBuf = {
            "<leader>gd" = "definition";
            "K" = "hover";
            "<leader>vws" = "workspace_symbol";
            "<leader>vca" = "code_action";
            "<leader>vrr" = "references";
            "<leader>vrn" = "rename";
          };
          diagnostic = {
            "<leader>vd" = "open_float";
            "[d" = "goto_next";
            "]d" = "goto_prev";
          };
        };
      };
      
      conform-nvim.enable = true;
     
      lint.enable = true;
      
      lsp-format.enable = true;

      codeium-vim = {
        enable = true;
        settings = {
          bin = "${pkgs.codeium}/bin/codeium_language_server";
        };
      };
      
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          mappingPresets = [ "insert" ];
          mapping = {
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-l>" =
              "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true, })";
          };
          snippet.expand = "luasnip";
          sources =
            [ { name = "nvim_lsp"; } { name = "luasnip"; } { name = "path"; } ];
        };
      };
      
      luasnip.enable = true;

      lualine = {
        enable = true;
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [ "branch" "diff" "diagnostics" ];
          lualine_c = [ "filename" ];
          lualine_x = [ "encoding" "fileformat" "filetype" ];
          lualine_y = [ "progress" ];
          lualine_z = [ "location" ];
        };
        inactiveSections = {
          lualine_a = [ ];
          lualine_b = [ ];
          lualine_c = [ "filename" ];
          lualine_x = [ "location" ];
          lualine_y = [ ];
          lualine_z = [ ];
        };
      };

      oil = {
        enable = true;
        defaultFileExplorer = true;
        viewOptions.showHidden = true;
      };

      comment-nvim.enable = true;

      notify = {
        enable = true;
        backgroundColour = "#000000";
        fps = 1;
        timeout = 2000;
      };

      surround.enable = true;

      telescope = {
        enable = true;
        keymaps = {
          "<leader>pf" = { action = "find_files"; };
          "<leader>ps" = { action = "grep_string"; };
        };
        extensions.fzf-native.enable = true;
      };
    };

    extraPlugins = [];

    extraConfigLua = "";
  };
}
