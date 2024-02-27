local vim = vim
return {
  'nvim-treesitter/nvim-treesitter',
  event = 'BufRead *',
  dependencies = {
    'windwp/nvim-autopairs',
    'windwp/nvim-ts-autotag',
    'RRethy/nvim-treesitter-endwise',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.wo.foldenable = false
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'go',
        'lua',
        'query',
        'javascript',
        'typescript',
        'tsx',
        'html',
        'json',
        'yaml',
        'bash',
        'python',
        'vue',
        'astro',
        'svelte',
        'rust',
        'toml',
        'dockerfile',
        'regex',
        'comment',
        'graphql',
        'php',
        'java',
        'awk',
        'cpp',
        'cmake',
        'make',
        'c_sharp',
        'css',
        'csv',
        'c',
        'git_config',
        'gitcommit',
        'gitignore',
        'git_rebase',
        'gitattributes',
        'gpg',
        'htmldjango',
        'http',
        'json5',
        'jsdoc',
        'jq',
        'luadoc',
        'markdown_inline',
        'markdown',
        'nix',
        'php',
        'passwd',
        'prisma',
        'proto',
        'ruby',
        'rust',
        'scss',
        'sql',
        'vim',
        'vimdoc',
        'vue',
        'xml',
        'yaml',
      },
      sync_install     = false,
      autoinstall      = true,
      highlight        = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      autotag          = {
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
        filetypes = { 'html', 'xml', 'vue', 'astro', 'javascript', 'typescript', 'tsx' },
      },
      endwise          = {
        enable = true,
      },
      textobjects      = {
        enable = true,
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            -- You can optionally set descriptions to the mappings (used in the desc parameter of
            -- nvim_buf_set_keymap) which plugins like which-key display
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            -- You can also use captures from other query groups like `locals.scm`
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V',  -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true of false
          include_surrounding_whitespace = false,
        },
      },
    })
  end,
}
