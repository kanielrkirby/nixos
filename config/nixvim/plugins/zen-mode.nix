{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = [{
      plugin = (pkgs.vimUtils.buildVimPlugin {
        name = "true-zen";
        src = pkgs.fetchFromGitHub {
          owner = "loqusion";
          repo = "true-zen.nvim";
          rev = "10390b9ce05a461d771013d888afd07d5db90ce0";
          sha256 = "sha256-0mfl4oyNOKJZWdMca/4F964HeGaTyn3ZhrRSsy5y6zw=";
        };
      });
    }];

    extraConfigLua = ''
      require("true-zen").setup {
        modes = { -- configurations per mode
            ataraxis = {
                shade = "dark", -- if `dark` then dim the padding windows, otherwise if it's `light` it'll brighten said windows
                backdrop = 0, -- percentage by which padding windows should be dimmed/brightened. Must be a number between 0 and 1. Set to 0 to keep the same background color
                minimum_writing_area = { -- minimum size of main window
                    width = 80,
                    height = 44,
                },
                quit_untoggles = true, -- type :q or :qa to quit Ataraxis mode
                padding = { -- padding windows
                    left = 52,
                    right = 52,
                    top = 0,
                    bottom = 0,
                },
                callbacks = { -- run functions when opening/closing Ataraxis mode
                    open_pre = nil,
                    open_pos = nil,
                    close_pre = nil,
                    close_pos = nil
                },
            },
        },
        integrations = {
            twilight = true, -- enable twilight (ataraxis)
            -- lualine = true -- hide nvim-lualine (ataraxis)
        },
      }

      vim.api.nvim_create_user_command(
        'ToggleZen',
        function(args)
          if not require("true-zen.ataraxis").running then
            require("true-zen.ataraxis").on()
            vim.g.__temp_colorcolumn = vim.o.colorcolumn
            vim.g.__temp_wrap = vim.o.wrap
            vim.g.__temp_linebreak = vim.o.linebreak
            vim.o.colorcolumn = ""
            vim.o.wrap = true
            vim.o.linebreak = true
            require("cmp").setup.buffer({ enabled = false })
          else
            require("true-zen.ataraxis").off()
            vim.o.colorcolumn = vim.g.__temp_colorcolumn
            vim.o.wrap = vim.g.__temp_wrap
            vim.o.linebreak = vim.g.__temp_linebreak
            require("cmp").setup.buffer({ enabled = true })
          end
        end,
        {}
      )
    '';
    keymaps = [
      {
        mode = "n";
        key = "<leader>z";
        action = "<cmd>ToggleZen<CR>";
      }
    ];
  };
}
