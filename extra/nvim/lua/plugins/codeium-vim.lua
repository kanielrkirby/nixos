local vim = vim

return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  config = function()
    vim.g.codeium_bin = "/home/mx/.nix-profile/bin/codeium_language_server"
  end
}
