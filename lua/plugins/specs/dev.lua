-- local completions = "nvim-cmp"
local completions = 'blink.cmp'
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
    cond = function(el)
      return completions == el.name
    end,
    dependencies = {
      -- "luckasRanarison/tailwind-tools.nvim",
      'onsails/lspkind-nvim', -- icons

      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',

      --- snippets
      -- {
      --   'garymjr/nvim-snippets',
      --   dependencies = {
      --     'rafamadriz/friendly-snippets',
      --   },
      --   opts = {
      --     create_cmp_source = true,
      --     friendly_snippets = true,
      --     search_paths = {
      --       --- ~/.config/nvim/snippets
      --       vim.fn.stdpath('config') .. '/snippets',
      --     },
      --   },
      -- },

      --# mini snippets
      {
        'abeldekat/cmp-mini-snippets',
        dependencies = 'echasnovski/mini.snippets',
      },
      {
        'echasnovski/mini.snippets',
        dependencies = 'rafamadriz/friendly-snippets',
        event = 'InsertEnter',
        config = require('plugins.configs.minisnipc'),
      },
    },
    event = { 'InsertEnter', 'VeryLazy' },
    config = require('plugins.configs.cmpc'),
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      -- 'moyiz/blink-emoji.nvim',
      -- 'hrsh7th/nvim-cmp',
    },
    cond = function(el)
      return completions == el.name
    end,
    -- event = { 'InsertEnter', 'VeryLazy' },
    lazy = false,
    -- version = 'v0.*', -- pre built binaries
    build = 'cargo build --release',
    init = function()
      -- Make an event to set change when a colorscheme is set
      local function vanshl(name, opts)
        vim.api.nvim_set_hl(0, name, opts or {})
      end

      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = '*',
        callback = function()
          -- vim.cmd.colorscheme('obscure')
          -- Customization for Pmenu
          vanshl('PmenuSel', { bg = '#282C34', fg = 'NONE' })
          vanshl('Pmenu', { fg = '#C5CDD9', bg = '#22252A' })

          vanshl('CmpItemAbbrDeprecated', { fg = '#7E8294', bg = 'NONE', strikethrough = true })
          vanshl('CmpItemAbbrMatch', { fg = '#82AAFF', bg = 'NONE', bold = true })
          vanshl('CmpItemAbbrMatchFuzzy', { fg = '#82AAFF', bg = 'NONE', bold = true })
          vanshl('CmpItemMenu', { fg = '#C792EA', bg = 'NONE', italic = true })

          vanshl('CmpItemKindField', { fg = '#EED8DA', bg = '#B5585F' })
          vanshl('CmpItemKindProperty', { fg = '#EED8DA', bg = '#B5585F' })
          vanshl('CmpItemKindEvent', { fg = '#EED8DA', bg = '#B5585F' })

          vanshl('CmpItemKindText', { fg = '#C3E88D', bg = '#9FBD73' })
          vanshl('CmpItemKindEnum', { fg = '#C3E88D', bg = '#9FBD73' })
          vanshl('CmpItemKindKeyword', { fg = '#C3E88D', bg = '#9FBD73' })

          vanshl('CmpItemKindConstant', { fg = '#FFE082', bg = '#D4BB6C' })
          vanshl('CmpItemKindConstructor', { fg = '#FFE082', bg = '#D4BB6C' })
          vanshl('CmpItemKindReference', { fg = '#FFE082', bg = '#D4BB6C' })

          vanshl('CmpItemKindFunction', { fg = '#EADFF0', bg = '#A377BF' })
          vanshl('CmpItemKindStruct', { fg = '#EADFF0', bg = '#A377BF' })
          vanshl('CmpItemKindClass', { fg = '#EADFF0', bg = '#A377BF' })
          vanshl('CmpItemKindModule', { fg = '#EADFF0', bg = '#A377BF' })
          vanshl('CmpItemKindOperator', { fg = '#EADFF0', bg = '#A377BF' })

          vanshl('CmpItemKindVariable', { fg = '#C5CDD9', bg = '#7E8294' })
          vanshl('CmpItemKindFile', { fg = '#C5CDD9', bg = '#7E8294' })

          vanshl('CmpItemKindUnit', { fg = '#F5EBD9', bg = '#D4A959' })
          vanshl('CmpItemKindSnippet', { fg = '#F5EBD9', bg = '#D4A959' })
          vanshl('CmpItemKindFolder', { fg = '#F5EBD9', bg = '#D4A959' })

          vanshl('CmpItemKindMethod', { fg = '#DDE5F5', bg = '#6C8ED4' })
          vanshl('CmpItemKindValue', { fg = '#DDE5F5', bg = '#6C8ED4' })
          vanshl('CmpItemKindEnumMember', { fg = '#DDE5F5', bg = '#6C8ED4' })

          vanshl('CmpItemKindInterface', { fg = '#D8EEEB', bg = '#58B5A8' })
          vanshl('CmpItemKindColor', { fg = '#D8EEEB', bg = '#58B5A8' })
          vanshl('CmpItemKindTypeParameter', { fg = '#D8EEEB', bg = '#58B5A8' })
        end,
      })
    end,
    config = require('plugins.configs.blinkc'),
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

  --- Squeletons
  {
    'cvigilv/esqueleto.nvim',
    cmd ={
      'EsqueletoNew'
    },
    config = require("lua.plugins.configs.esqueletoc")
  }
}
