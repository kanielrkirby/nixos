local vim = vim

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
  },
  keys = {
    'n', '<leader>pf',
    'n', '<C-p>',
    'n', '<leader>ps',
  },
  cmd = "Telescope",
  config = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set('n', '<leader>pf', builtin.find_files, { noremap = true, silent = true })
    vim.keymap.set('n', '<C-p>', builtin.git_files, { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>ps', function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end,
      { noremap = true, silent = true })
  end
}
