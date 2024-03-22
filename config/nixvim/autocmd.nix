{ inputs, ... }:

let
  Writing = {
    __raw = ''
      function()
        print("Zen mode enabled")
      end
    '';
  };
in {
  programs.nixvim.autoCmd = [
    {
      event = [ "BufEnter" ];
      pattern = [ "*.md" ];
      desc = "Enable zen mode";
      callback = Writing;
    }
  ];
}
