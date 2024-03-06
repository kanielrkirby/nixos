{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      treesitter = {
        ensureInstalled = [
          "css"
        ];
      };
      
      conform-nvim = {
        formattersByFt = {
          css = [ "prettierd" ];
        };
      };
     
      lint = {
        enable = true;
        lintersByFt = {
          nix = [ "statix" ];
          typescript = [ "eslint_d" ];
          javascript = [ "eslint_d" ];
          lua = [ "luacheck" ];
          go = [ "golangcilint" ];
          docker = [ "hadolint" ];
          css = [ "stylelint" ];
        };
        linters = {
          statix = { cmd = "${pkgs.statix}/bin/statix"; };
          eslint_d = { cmd = "${pkgs.eslint_d}/bin/eslint_d"; };
          luacheck = { cmd = "${pkgs.lua54Packages.luacheck}/bin/luacheck"; };
          golangcilint = { cmd = "${pkgs.golangci-lint}/bin/golangci-lint"; };
          hadolint = { cmd = "${pkgs.hadolint}/bin/hadolint"; };
          stylelint = { cmd = "${pkgs.stylelint}/bin/stylelint"; };
        };
      };
    };
  };
}
