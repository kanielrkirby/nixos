local vim = vim

return {
  'tpope/vim-fugitive',
  cmd = 'G',
  keys = {
    '<leader>gs',
  },
  config = function()
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
  end
}
