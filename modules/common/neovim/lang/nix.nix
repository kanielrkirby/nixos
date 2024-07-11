{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      nix.enable = true;
      nix-develop.enable = true;
      dap.extensions.dap-go.enable = true;

      treesitter.nixvimInjections = true;
      
      lsp.servers = {
        nixd.enable = true;
      };

      conform-nvim = {
        formattersByFt.nix = [ "nixfmt-rfc-style" ];
        formatters.nixfmt-rfc-style.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt-rfc-style";
      };
     
      lint = {
        lintersByFt.nix = [ "statix" ];
        linters.statix.cmd = "${pkgs.statix}/bin/statix";
      };
    };
  };
}
