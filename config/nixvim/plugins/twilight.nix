{
  programs.nixvim.plugins.twilight = {
    enable = true;
    settings = {
      dimming = {
        alpha = 0.4;
        color = [ "Normal" "#ffffff" ];
        term_bg = "#000000";
        inactive = false;
      };
      context = 1;
      treesitter = true;
      expand = [ "function" "method" "table" "if_statement" ];
    };
  };
}
