{ pkgs, ... }:

{
  programs.nixvim = {
    plugins.noice = {
      enable = true;
      package = pkgs.vimPlugins.noice-nvim.overrideAttrs rec {
        version = "2.0.2";
        src = pkgs.fetchFromGitHub {
          owner = "folke";
          repo = "noice.nvim";
          rev = "v${version}";
          sha256 = "sha256-YWqphpaxr/729/6NTDEWKOi2FnY/8xgjdsDQ9ePj7b8=";
        };
      };
      presets = {
        command_palette = true;
        long_message_to_split = true;
        inc_rename = false;
        lsp_doc_border = true;
      };
    };
  };
}
