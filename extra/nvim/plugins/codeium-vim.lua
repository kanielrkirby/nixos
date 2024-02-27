local vim = vim

return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  config = function()
    tools = {
      language_server = "/home/mx/.nix-profile/bin/codeium_language_server"
    }
  end
}
