{ inputs, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      nix.enable = true;
      nix-develop.enable = true;
      dap.extensions.dap-go.enable = true;

      treesitter.ensureInstalled = [ "nix" ];
      
      lsp.servers = {
        nixd.enable = true;
      };

      conform-nvim = {
        formattersByFt.nix = [ "nixfmt" ];
        formatters.nixfmt.command = "${pkgs.nixfmt}/bin/nixfmt";
      };
     
      lint = {
        lintersByFt.nix = [ "statix" ];
        linters.statix.cmd = "${pkgs.statix}/bin/statix";
      };
    };
  };
}
