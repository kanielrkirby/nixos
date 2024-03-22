{ inputs, ... }:

let
  Writing = {
    __raw = ''
      function(args)
        if vim.bo.filetype == "markdown" or vim.bo.filetype == "txt" then
          if args.event == "BufEnter" or args.event == "WinEnter" then
            if not require("true-zen.ataraxis").running then
              require("true-zen.ataraxis").on()
              vim.g.__temp_colorcolumn = vim.o.colorcolumn
              vim.g.__temp_wrap = vim.o.wrap
              vim.g.__temp_linebreak = vim.o.linebreak
              vim.o.colorcolumn = ""
              vim.o.wrap = true
              vim.o.linebreak = true
              require("cmp").setup.buffer({ enabled = false })
            end
          else
            if require("true-zen.ataraxis").running then
              require("true-zen.ataraxis").off()
              vim.o.colorcolumn = vim.g.__temp_colorcolumn
              vim.o.wrap = vim.g.__temp_wrap
              vim.o.linebreak = vim.g.__temp_linebreak
              require("cmp").setup.buffer({ enabled = true })
            end
          end
        end
      end
    '';
  };
in {
  programs.nixvim.autoCmd = [
    {
      event = [ "BufEnter" "BufLeave" "WinEnter" "WinLeave" ];
      desc = "Toggle Writing Mode";
      callback = Writing;
    }
  ];
}
