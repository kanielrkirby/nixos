{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      lsp.servers.gopls.enable = true;
      
      conform-nvim = {
        formattersByFt.go = [ "goimports" ];
      
        formatters.goimports = {
          command = "${pkgs.gotools}/bin/goimports";
          args = [ "-local" "gitlab.com/majiy00,gitlab.com/hmajid2301" ];
        };
      };
     
      lint = {
        lintersByFt.go = [ "golangcilint" ];
        linters.golangcilint.cmd = "${pkgs.golangci-lint}/bin/golangci-lint";
      };
    };
  };
}
