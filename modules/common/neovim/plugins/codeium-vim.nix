{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      codeium-vim = {
        enable = false;
        settings = { bin = "${pkgs.codeium}/bin/codeium_language_server"; };
      };
    };
  };
}
