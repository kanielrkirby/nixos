return {
  "hrsh7th/nvim-cmp",
  event = { 'InsertEnter' },
  dependencies = {
    { 'L3MON4D3/LuaSnip' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path' },
  },
  config = function()
    local cmp = require('cmp')

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-l>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
      }),
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'codeium' },
      }
    })
  end
}
