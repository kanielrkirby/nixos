{ inputs, pkgs, ... }:

{

    imports = [
        inputs.nixvim.nixosModules.nixvim
    ];

    programs.nixvim = {
        enable = true;

        colorschemes.gruvbox.enable = true;

        plugins = {
            # none-ls = {
            #   enable = true;
            #   enableLspFormat = true;
            #   sources = {
            #     formatting = {

            #     };
            #     diagnostics = {};
            #     code_actions = {};
            #   };
            # };

            treesitter = {
                enable = true;
                folding = true;
                indent = true;
                ensureInstalled = [
                    "go"
                    "lua"
                    "query"
                    "javascript"
                    "typescript"
                    "tsx"
                    "html"
                    "json"
                    "yaml"
                    "bash"
                    "python"
                    "vue"
                    "astro"
                    "svelte"
                    "rust"
                    "toml"
                    "dockerfile"
                    "regex"
                    "comment"
                    "graphql"
                    "java"
                    "awk"
                    "cpp"
                    "cmake"
                    "make"
                    "c_sharp"
                    "css"
                    "csv"
                    "c"
                    "git_config"
                    "gitcommit"
                    "gitignore"
                    "git_rebase"
                    "gitattributes"
                    "gpg"
                    "htmldjango"
                    "http"
                    "json5"
                    "jsdoc"
                    "jq"
                    "luadoc"
                    "markdown_inline"
                    "markdown"
                    "nix"
                    "passwd"
                    "prisma"
                    "proto"
                    "ruby"
                    "rust"
                    "scss"
                    "sql"
                    "vim"
                    "vimdoc"
                    "vue"
                    "xml"
                    "yaml"
                    "nix"
                    ];
            };
            ts-autotag.enable = true;
            nvim-autopairs = {
                enable = true;
                checkTs = true;
            };

            #codeium-vim = {
            #    enable = true;
            #};

            lsp = {
              enable = true;
              servers = { 
                astro.enable = true;
                bashls.enable = true;
                biome.enable = true;
                emmet_ls.enable = true;
                eslint.enable = true;
                gopls.enable = true;
                html.enable = true;
                # jedi_language_server.enable = true;
                lua-ls.enable = true;
                nixd.enable = true;
                # stylelint_lsp.enable = true;
                # sqlls.enable = true;
                tailwindcss.enable = true;
                volar.enable = true;
              };
              keymaps = {
                silent = true;
                lspBuf = {
                  "<leader>gd" = "definition";
                  "K" = "hover";
                  "<leader>vws" = "workspace_symbol";
                  "<leader>vca" = "code_action";
                  "<leader>vrr" = "references";
                  "<leader>vrn" = "rename";
                  "<leader>F" = "format";
                };
                diagnostic = {
                  "<leader>vd" = "open_float";
                  "[d" = "goto_next";
                  "]d" = "goto_prev";
                };
              };
            };

            nvim-cmp = {
                enable = true;
                autoEnableSources = true;
                mappingPresets = [ "insert" ];
                mapping = {
                    "<C-k>" = "cmp.mapping.select_prev_item()";
                    "<C-j>" = "cmp.mapping.select_next_item()";
                    "<C-l>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true, })";
                };
                snippet.expand = "luasnip";
                sources = [
                  { name = "nvim_lsp"; }
                  { name = "luasnip"; }
                  { name = "path"; }
                  { name = "codeium"; }
                ];
            };
            cmp-nvim-lsp.enable = true;
            cmp-path.enable = true;
            luasnip.enable = true;

#             conform-nvim = {
#                 enable = true;
#                 formattersByFt = {
#                     lua = [ "stylua" ];
#                     nix = [ "nixd" ];
#                     "*" = [ "codespell" ];
#                     "_" = [ "trim_whitespace" ];
#                 };
#             };

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
                    lualine_a = [  ];
                    lualine_b = [  ];
                    lualine_c = [ "filename" ];
                    lualine_x = [ "location" ];
                    lualine_y = [  ];
                    lualine_z = [  ];
                };

            };

            oil = {
                enable = true;
                defaultFileExplorer = true;
                viewOptions = {
                    showHidden = true;
                };
            };

            comment-nvim = {
                enable = true;
            };

            noice = {
                enable = true;
                cmdline.enabled = true;
                messages.enabled = true;
                popupmenu.enabled = true;
                notify.enabled = true;
            };

            notify = {
                enable = true;
                backgroundColour = "#000000";
                fps = 1;
            };

            surround = {
                enable = true;
            };

            telescope = {
                enable = true;
                keymaps = {
                    "<leader>pf" = { action = "find_files"; };
                    "<C-p>" = { action = "git_files"; };
                    "<leader>ps" = { action = "grep_string"; };
                };
                extensions.fzf-native.enable = true;
            };

            gitsigns.enable = true;
            fugitive.enable = true;

            undotree = {
                enable = true;
            };
        };

        options = {
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
            undodir = "/etc/nixos/extra/nvim/undodir";

            hlsearch = false;
            incsearch = true;

            termguicolors = true;

            scrolloff = 8;
            signcolumn = "yes";

            updatetime = 50;

            colorcolumn = "80";
        };

        keymaps = [
        {
            mode = "n"; key = "<leader>pv"; action = "<cmd>Oil<CR>";
        }
        {
            mode = "v"; key = "J"; action = ":m '>+1<CR>gv=gv";
        }
        {
            mode = "v"; key = "K"; action = ":m '<-2<CR>gv=gv";
        }

        {
            mode = "n"; key = "J"; action = "mzJ`z";
        }
        {
            mode = "n"; key = "<C-d>"; action = "<C-d>zz";
        }
        {
            mode = "n"; key = "<C-u>"; action = "<C-u>zz";
        }
        {
            mode = "n"; key = "n"; action = "nzzzv";
        }
        {
            mode = "n"; key = "N"; action = "Nzzzv";
        }
        {
            mode = "x"; key = "<leader>p"; action = "\"_dP";
        }

        {
            mode = "n"; key = "<leader>y"; action = "\"+y";
        }
        {
            mode = "v"; key = "<leader>y"; action = "\"+y";
        }
        {
            mode = "n"; key = "<leader>Y"; action = "\"+Y";
        }
        {
            mode = "n"; key = "<leader>d"; action = "\"+d";
        }
        {
            mode = "v"; key = "<leader>d"; action = "\"+d";
        }
        {
            mode = "n"; key = "<leader>D"; action = "\"+D";
        }

        {
            mode = "i"; key = "<C-c>"; action = "<Esc>";
        }

        {
            mode = "n"; key = "Q"; action = "<nop>";
        }
        {
            mode = "n"; key = "<C-k>"; action = "<cmd>cprev<CR>zz";
        }
        {
            mode = "n"; key = "<C-j>"; action = "<cmd>cnext<CR>zz";
        }
        {
            mode = "n"; key = "<leader>k"; action = "<cmd>cprev<CR>zz";
        }
        {
            mode = "n"; key = "<leader>j"; action = "<cmd>cnext<CR>zz";
        }

        {
            mode = "n"; key = "<leader>s"; action = "[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]";
        }
        {
            mode = "n"; key = "<leader>S"; action = "[[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]]";
        }

        {
            mode = "n"; key = "<A-h>"; action = "<C-w>h";
        }
        {
            mode = "n"; key = "<A-j>"; action = "<C-w>j";
        }
        {
            mode = "n"; key = "<A-k>"; action = "<C-w>k";
        }
        {
            mode = "n"; key = "<A-l>"; action = "<C-w>l";
        }
        {
            mode = "i"; key = "<A-h>"; action = "<C-w>h";
        }
        {
            mode = "i"; key = "<A-j>"; action = "<C-w>j";
        }
        {
            mode = "i"; key = "<A-k>"; action = "<C-w>k";
        }
        {
            mode = "i"; key = "<A-l>"; action = "<C-w>l";
        }
        {
            mode = "t"; key = "<A-h>"; action = "<C-\\><C-n><C-w>h";
        }
        {
            mode = "t"; key = "<A-j>"; action = "<C-\\><C-n><C-w>j";
        }
        {
            mode = "t"; key = "<A-k>"; action = "<C-\\><C-n><C-w>k";
        }
        {
            mode = "t"; key = "<A-l>"; action = "<C-\\><C-n><C-w>l";
        }

#-- open terminal in new split
        {
            mode = "n"; key = "<C-w>en"; action = "<cmd>split term://zsh<CR>";
        }
        {
            mode = "n"; key = "<C-w>ev"; action = "<cmd>vsplit term://zsh<CR>";
        }
        {

            mode = "n"; key = "<leader>f"; lua = true; action = ''
                function (args)
                     require('conform').format({ async = true, lsp_fallback = true })
                end
            '';
        }
        ];

        globals = {
            mapleader = " ";
            netrw_keepdir = 1;
            netrw_localcopydircmd = "cp -r";
            netrw_banner = 0;
            user_emmet_leader_key = "<C-,>";
        };
    };
}
