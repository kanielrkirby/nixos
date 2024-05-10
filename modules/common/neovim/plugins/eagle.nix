{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "eagle";
        src = pkgs.fetchFromGitHub {
          owner = "soulis-1256";
          repo = "eagle.nvim";
          rev = "dd535a24930e75795569a211d442a49b7d401082";
          sha256 = "sha256-5ioY75O6stBLvv/5Xrwcfubhk0x1K4NiHTvUhIJS6HE=";
        };
      })
    ];
    extraConfigLua = ''
      require("eagle").setup({
      -- override the default values found in config.lua
      })

      -- make sure mousemoveevent is enabled
      vim.o.mousemoveevent = true
    '';
  };
}
