{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      rustaceanvim.enable = true;
      conform-nvim = {
        formattersByFt.rust = [ "rustfmt" ];
        formatters.rustfmt.command = "${pkgs.rustfmt}/bin/rustfmt";
      };
    };
  };
}
