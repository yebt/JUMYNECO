return {

  --- Autopairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({
        disable_filetype = { 'TelescopePrompt', 'vim' },
      })
    end,
  },

  --- Completions
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      "luckasRanarison/tailwind-tools.nvim",
      "onsails/lspkind-nvim",

      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      --- snippets
      {
        'garymjr/nvim-snippets',
        dependencies = {
          'rafamadriz/friendly-snippets',
        },
        opts = {
          create_cmp_source = true,
          friendly_snippets = true,
          search_paths = {
            --- ~/.config/nvim/snippets
            vim.fn.stdpath('config') .. '/snippets',
          },
        },
      },
    },
    event = { 'InsertEnter', 'VeryLazy' },
    config = require('plugins.configs.cmp'),
  },

  -- Automatically add closing tags for HTML and JSX
  {
    'windwp/nvim-ts-autotag',
    event = 'LazyFile',
    -- event = 'VeryLazy',
    opts = {
      opts = {
        -- Defaults
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
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

  --- Emmet
  -- {
  --   'mattn/emmet-vim',
  --   event = 'VeryLazy',
  -- },

  --- AI
  {
    'supermaven-inc/supermaven-nvim',
    --  event = 'VeryLazy',
    event = { 'InsertEnter' },
    config = require('plugins.configs.smaven'),
  },

  --- Runner
  {
    'stevearc/overseer.nvim',
    dependencies = {
      -- 'nvim-lua/plenary.nvim',
      -- 'nvim-telescope/telescope.nvim',
      'akinsho/toggleterm.nvim',
    },
    config = require('plugins.configs.overseerc'),
    cmd = {
      'OverseerRun',
      'OverseerOpen',
      'OverseerClose',
      'OverseerToggle',
      'OverseerSaveBundle',
      'OverseerLoadBundle',
      'OverseerDeleteBundle',
      'OverseerRunCmd',
      'OverseerRun',
      'OverseerInfo',
      'OverseerBuild',
      'OverseerQuickAction',
      'OverseerTaskAction',
      'OverseerClearCache',
    },
    keys = {
      { 'ø', ':OverseerRun<CR>' },
      { '<C-j>', ':OverseerToggle<CR>' },
    },
  },

}
