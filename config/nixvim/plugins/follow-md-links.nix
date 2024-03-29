{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = [{
      plugin = (pkgs.vimUtils.buildVimPlugin {
        name = "follow-md-links.nvim";
        src = pkgs.fetchFromGitHub {
          owner = "jghauser";
          repo = "follow-md-links.nvim";
          rev = "master";
          sha256 = "sha256-9y8Z8wEgqKQ+YYtb7w0yYB2+KjBh5iW6Q5ZkQsQ7xY=";
        };
      });
    }];

    extraConfigLua = ''
      require("follow-md-links").setup { }
    '';
  };
}
