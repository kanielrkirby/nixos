local vim = vim

local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins, themes)
  if vim.g.plugins_ready then
    return
  end

  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)

  for i, theme in ipairs(themes) do
    table.insert(plugins, theme)
    if i == 1 then
      vim.g.colors_name = theme
    end
  end

  require('lazy').setup(plugins, lazy.opts)

  vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

local themes = {
  -- 'rose-pine/neovim',
  -- 'folke/tokyonight.nvim',
  -- 'sainnhe/edge',
  "catppuccin/nvim",
}

lazy.setup({{import = 'plugins'}}, themes)

function Color(color)
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
	vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
end

Color('catppuccin')

