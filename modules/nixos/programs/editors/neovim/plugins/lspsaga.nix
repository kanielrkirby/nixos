{
  programs.nixvim = {
    plugins.lspsaga = {
      enable = false;
      symbolInWinbar.enable = false;
    };
    plugins.lspkind.enable = true;
  };
}
