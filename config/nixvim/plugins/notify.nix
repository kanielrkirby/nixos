{
  programs.nixvim = {
    plugins = {
      notify = {
        enable = true;
        backgroundColour = "#000000";
        fps = 1;
        timeout = 2000;
      };
    };
  };
}
