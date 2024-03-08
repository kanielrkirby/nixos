{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      codeium-vim = {
        enable = true;
        settings = { bin = "${pkgs.codeium}/bin/codeium_language_server"; };
      };
    };
  };
}
