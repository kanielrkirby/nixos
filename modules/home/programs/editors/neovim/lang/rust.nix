{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "tree-sitter-rstml";
        src = pkgs.fetchFromGitHub {
          owner = "rayliwell";
          repo = "tree-sitter-rstml";
          rev = "eac3ef6ccd4192dc9d2c2103a0067a49cc1e435e";
          sha256 = "sha256-pmB/IeNumce5+em2vBUS7NwT0gEr5YuVLU4qaCQwt/A=";
        };
        config = ''
          require("tree-sitter-rstml").setup()
        '';
      })
    ];

    plugins = {
      crates-nvim.enable = true;
      lsp.servers.tailwindcss = {
        filetypes = [
          "rust"
        ];
        extraOptions = {
          init_options = {
            userLanguages = {
              rust = "html";
            };
          };
        };
      };
      rustaceanvim = {
        enable = true;
        rustAnalyzerPackage = null;
        tools.hoverActions.replaceBuiltinHover = true;
        extraOptions.server.default_settings.rust-analyzer = {
          cargo.features = "all";
          procMacro.enable = true;
        };
      };
      conform-nvim = {
        formattersByFt.rust = ["rustfmt"];
        formatters.rustfmt.command = "${pkgs.rustfmt}/bin/rustfmt";
      };
    };
  };
}
