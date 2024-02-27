local vim = vim

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.cmd [[
  autocmd FileType markdown setlocal tabstop=2 shiftwidth=2 expandtab
]]

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.config/nvim/undodir')

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

vim.opt.updatetime = 50

vim.opt.colorcolumn = '80'

vim.g.mapleader = ' '

vim.g.netrw_keepdir = 1
vim.g.netrw_localcopydircmd = 'cp -r'
vim.g.netrw_banner = 0

vim.api.nvim_command('autocmd FileType markdown setlocal wrap')

vim.g.user_emmet_leader_key = '<C-,>'

vim.o.termguicolors = true

vim.filetype.add({
  pattern = { [".*/hyprland%.conf"] = "hyprlang" },
})
vim.filetype.add({
  pattern = { ["*.yuck"] = "yuck" },
})
