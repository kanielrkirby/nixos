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
    '';
  };
}
