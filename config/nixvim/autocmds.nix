{ inputs, ... }:

{
  programs.nixvim.autoCmd = [
    {
      event = [ "BufEnter" "BufWinEnter" ];
      pattern = [ "*.txt" "*.md" ];
      command = ''lua (
        function()
          require("zen-mode").toggle()
        end
      )()'';
    }
    {
      event = [ "BufLeave" "BufWinLeave" ];
      pattern = [ "*.txt" "*.md" ];
      command = ''lua (
        function()
          require("zen-mode").toggle()
        end
      )()'';
    }
  ];
}
