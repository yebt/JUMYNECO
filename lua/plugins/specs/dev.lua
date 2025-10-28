--- Plugings to coding
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
    -- OR build from source
    build = 'cargo +nightly build --release',
    event = { 'VeryLazy', 'InsertEnter' },
    dependencies = {},
    --- @module 'blink.pairs'
    --- @type blink.pairs.Config
    opts = {
      mappings = {
        -- you can call require("blink.pairs.mappings").enable() and require("blink.pairs.mappings").disable() to enable/disable mappings at runtime
        enabled = true,
        -- see the defaults: https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L10
        pairs = {
          ['<'] = {
            { '<', '>', when = function(ctx) return ctx.ts:whitelist('angle').matches end, languages = { 'rust' } },
            {
              '<',
              '>',
              when = function(ctx)
                return ctx.char_under_cursor:match('%w')
              end,
              languages = { 'typescript' }
            }
          },
          ['>'] = {
            { '>', '<', space = true, enter = true, languages = { 'html', 'vue' } }
          },
          ['!'] = {
            { '<!--', '-->', languages = { 'html', 'markdown', 'markdown_inline' } }
          },
          ['('] = { ')', space = true, enter = true },
          ['['] = { ']', space = true, enter = true },
          ['{'] = { '}', space = true, enter = true },
          ['*'] = { {
            '*',
            ' */',
            when = function()
              local cursor = vim.api.nvim_win_get_cursor(0)
              local line = vim.api.nvim_get_current_line()
              return line:sub(cursor[2] - 1, cursor[2]) == '/*'
            end,
            enter = true,
            space = false,
            backspace = false,
            languages = { 'php', 'phtml' }
          } },
          ['`'] = {
            {
              '```',
              when = function(ctx) return ctx:text_before_cursor(2) == '``' end,
              languages = { 'markdown', 'markdown_inline', 'typst', 'vimwiki', 'rmarkdown', 'rmd', 'quarto' },
            },
            {
              '`',
              "'",
              languages = { 'bibtex', 'latex', 'plaintex' },
            },
            { '`', enter = false, space = false },
          },
        },
      },
      highlights = {
        enabled = true,
        groups = {
          'BlinkPairsOrange',
          'BlinkPairsPurple',
          'BlinkPairsBlue',
        },
        matchparen = {
          enabled = true,
          group = 'MatchParen',
        },
      },
      debug = false,
    },
  },


  --- File sistem iteration
  {
    'echasnovski/mini.files',
    version = false,
    dependencies = { 'echasnovski/mini.icons' },
    config = require('plugins.configs.mini-files-c'),
    keys = {
      {
        '\\',
        function()
          local ok, mf = pcall(require, 'mini.files')
          if not ok then
            return
          end
          if not mf.close() then
            mf.open()
          end
        end,
        silent = true,
        desc = 'Toggle Mini Files',
      },
      {
        '¿',
        function()
          local ok, mf = pcall(require, 'mini.files')
          if not mf.close() then
            MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
          end
        end,
        silent = true,
        desc = 'Toggle Mini Files try reveal',
      },
    },
  },


  --- Comments
  {
    -- cond = false,
    'numToStr/Comment.nvim',
    opts = {
      padding = true,
      ---Whether the cursor should stay at its position
      sticky = true,
      ---Lines to be ignored while (un)comment
      ignore = nil,
      ---LHS of toggle mappings in NORMAL mode
      toggler = {
        ---Line-comment toggle keymap
        line = 'gcc',
        ---Block-comment toggle keymap
        block = 'gbc',
      },
      ---LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
        ---Line-comment keymap
        line = 'gc',
        ---Block-comment keymap
        block = 'gb',
      },
      ---LHS of extra mappings
      extra = {
        ---Add comment on the line above
        above = 'gcO',
        ---Add comment on the line below
        below = 'gco',
        ---Add comment at the end of line
        eol = 'gcA',
      },
      ---Enable keybindings
      ---NOTE: If given `false` then the plugin won't create any mappings
      mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
      },
      ---Function to call before (un)comment
      pre_hook = nil,
      ---Function to call after (un)comment
      post_hook = nil,
    },
    keys = {
      { "gc", mode = { 'x', 'n' }, desc = "Toggle line comment" },
      { "gb", mode = { 'x', 'n' }, desc = "Toggle block comment" },
    }
  },

  --- Completion
  -- {
  --   'saghen/blink.cmp',
  --   version = '1.*',
  --   -- Provee snippets VSCode-style (incluye PHPDoc)
  --   dependencies = { 'rafamadriz/friendly-snippets' },
  --   event = { 'VeryLazy', 'InsertEnter' },
  --   opts = {
  --     -- Habilita la fuente de snippets junto a LSP, path y buffer
  --     sources = {
  --       default = { 'lsp', 'path', 'snippets', 'buffer' },
  --     },
  --     -- Usa la configuración por defecto de snippets (vim.snippet)
  --     -- Para LuaSnip, ver ejemplo en turn9view0
  --   },
  -- },

  --- Completion
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
      --- Ads
      'rafamadriz/friendly-snippets',
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
        dependencies = {
          'rafamadriz/friendly-snippets',
        },
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
          require('luasnip.loaders.from_vscode').lazy_load({ paths = { './snippets' } })
        end,
      },

      --- Comunity sources
    {
      "mikavilpas/blink-ripgrep.nvim",
      version = "*", -- use the latest stable version
    }

    },
    build = 'cargo +nightly build --release',
    event = { 'VeryLazy', 'InsertEnter' },
    -- opts_extend = { 'sources.default' },
    config = require("plugins.configs.blink-c.normalv")
    -- config = require("plugins.configs.blink-c.minimalv")
  },

  -- notify progress
  {
    "j-hui/fidget.nvim",
    event = { 'LspAttach', 'VeryLazy' },
    opts = {
      -- options
      progress = {
        ignore_done_already = false
      },
    },
  }

}
