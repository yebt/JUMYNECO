-- local completions = "nvim-cmp"
return {

  --- Autopairs
  -- {
  --   'windwp/nvim-autopairs',
  --   event = 'InsertEnter',
  --   config = function()
  --     require('nvim-autopairs').setup({
  --       disable_filetype = { 'TelescopePrompt', 'vim' },
  --     })
  --   end,
  -- },

  --- Autopairs better version with rainbow
  {
    'saghen/blink.pairs',
    -- build = 'cargo build --release', -- build from source
    -- NOTE:sometimes need nightly version, remember install nightly: `rustup install nightly`
    build = 'cargo +nightly build --release',
    event = { 'InsertEnter', 'VeryLazy' },
    config = require('plugins.configs.blinkpairsc')
  },

  -- Completions wiith rust
  {
    'saghen/blink.cmp',
    dependencies = {
      --- Ads
      'rafamadriz/friendly-snippets',
      'echasnovski/mini.icons',

      -- {
      --   'L3MON4D3/LuaSnip',
      --   -- follow latest release.
      --   version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      --   -- install jsregexp (optional!).
      --   build = 'make install_jsregexp',
      -- },
      -- {
      --   'echasnovski/mini.snippets',
      --   version = '*',
      --   dependencies = { 'rafamadriz/friendly-snippets' },
      --   config = function()
      --     require('mini.snippets').setup({
      --       mappings = {
      --         -- Expand snippet at cursor position. Created globally in Insert mode.
      --         expand = '<C-j>',
      --         -- Interact with default `expand.insert` session.
      --         -- Created for the duration of active session(s)
      --         jump_next = '<C-l>',
      --         jump_prev = '<C-h>',
      --         stop = '<C-c>',
      --       },
      --     })
      --   end,
      -- },

      --- Snippets
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        config = function()
          local ls = require('luasnip')
          -- ls.filetype_extend('all', { 'global' })
          require('luasnip.loaders.from_vscode').lazy_load()
          require('luasnip.loaders.from_vscode').lazy_load({
            paths = { vim.fn.stdpath('config') .. '/snippets' },
          })
        end,
      },

      --- Comunity sources
      "mikavilpas/blink-ripgrep.nvim",
    },
    event = { 'InsertEnter', 'VeryLazy' },
    -- lazy = false,
    -- version = 'v0.*', -- pre built binaries
    build = 'cargo build --release',
    -- init = require('plugins.inits.blinki'),
    -- init = function()
    -- end,
    -- config = require('plugins.configs.blinkc'),
    config = require('plugins.configs.blinkc3'),
  },

  -- Automatically add closing tags for HTML and JSX
  {
    'windwp/nvim-ts-autotag',
    event = 'LazyFile',
    -- event = 'VeryLazy',
    opts = {
      opts = {
        -- Defaults
        enable_close = true,          -- Auto close tags
        enable_rename = true,         -- Auto rename pairs of tags
        enable_close_on_slash = true, -- Auto close on trailing </
      },
      -- Also override individual filetype configs, these take priority.
      -- Empty by default, useful if one of the "opts" global settings
      -- doesn't work well in a specific filetype
      -- per_filetype = {
      --   ['html'] = {
      --     enable_close = false,
      --   },
      -- },
    },
  },

  --- neotest
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },

  --- Templates
  {
    'yebt/stencil.nvim',
    -- dev = true,
    cmd = {
      'Stencil',
    },
    -- lazy = false,
    config = function()
      require('stncl').setup({})
    end,
  },

}
