{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = [
      {
        plugin = pkgs.vimUtils.buildVimPlugin {
          name = "follow-md-links.nvim";
          src = pkgs.fetchFromGitHub {
            owner = "jghauser";
            repo = "follow-md-links.nvim";
            rev = "master";
            sha256 = "sha256-ElgYrD+5FItPftpjDTdKAQR37XBkU8mZXs7EmAwEKJ4=";
          };
        };
      }
    ];

    extraConfigLua = ''
    '';
  };
}
