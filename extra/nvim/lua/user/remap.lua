local vim = vim

--vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pv", vim.cmd.Oil)

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('x', '<leader>p', '"_dP')

vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')
vim.keymap.set('n', '<leader>d', '"+d')
vim.keymap.set('v', '<leader>d', '"+d')
vim.keymap.set('n', '<leader>D', '"+D')

vim.keymap.set('i', '<C-c>', '<Esc>')

vim.keymap.set('n', 'Q', '<nop>')
--vim.keymap.set('n', '<leader>f', function()
--  vim.lsp.buf.format()
--end)

vim.keymap.set('n', '<C-k>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>cnext<CR>zz')

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])

vim.keymap.set('n', '<A-h>', '<C-w>h')
vim.keymap.set('n', '<A-j>', '<C-w>j')
vim.keymap.set('n', '<A-k>', '<C-w>k')
vim.keymap.set('n', '<A-l>', '<C-w>l')
vim.keymap.set('i', '<A-h>', '<C-w>h')
vim.keymap.set('i', '<A-j>', '<C-w>j')
vim.keymap.set('i', '<A-k>', '<C-w>k')
vim.keymap.set('i', '<A-l>', '<C-w>l')
vim.keymap.set('t', '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<A-l>', '<C-\\><C-n><C-w>l')

-- open terminal in new split
vim.keymap.set('n', '<C-w>en', '<cmd>split term://zsh<CR>')
vim.keymap.set('n', '<C-w>ev', '<cmd>vsplit term://zsh<CR>')
