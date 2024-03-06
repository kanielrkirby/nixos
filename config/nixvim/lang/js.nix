{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      treesitter.ensureInstalled = [
        "astro"
        "biome"
        "css"
        "html"
        "javascript"
        "typescript"
        "vue"
      ];

      lsp.servers = {
        astro.enable = true;
        biome.enable = true;
        eslint.enable = true;
        tailwindcss.enable = true;
        volar.enable = true;
        emmet_ls.enable = true;
        html = {
          enable = true;
          extraOptions.settings = {
            html = {
              format = {
                templating = true;
                wrapLineLength = 120;
                wrapAttributes = "auto";
              };
              hover = {
                documentation = true;
                references = true;
              };
            };
          };
        };
        jsonls.enable = true;
      };
      
      conform-nvim = {
        formattersByFt = {
          html = [ "prettierd" ];
          javascript = [ "prettierd" ];
          typescript = [ "prettierd" ];
          css = [ "prettierd" ];
        };
      
        formatters.prettierd.command = "${pkgs.prettierd}/bin/prettierd";
      };
     
      lint = {
        lintersByFt = {
          typescript = [ "eslint_d" ];
          javascript = [ "eslint_d" ];
          css = [ "stylelint" ];
        };
        linters = {
          eslint_d.cmd = "${pkgs.eslint_d}/bin/eslint_d";
          stylelint.cmd = "${pkgs.stylelint}/bin/stylelint";
        };
      };
    };
  };
}
