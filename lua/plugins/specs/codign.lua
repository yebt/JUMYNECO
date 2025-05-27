--- This plugins are needed to coding
return {

 --- Automatically add closing tags for HTML and JSX
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

  --- Autopairs
  {
    'saghen/blink.pairs',
    -- build = 'cargo build --release', -- build from source
    -- NOTE:sometimes need nightly version, remember install nightly: `rustup install nightly`
    build = 'cargo +nightly build --release',
    event = { 'InsertEnter', 'User PostVeryLazy' },
    config = function()
      local blnkp = require('blink.pairs')

      local function makePair(pairStr)
        return {
          pairStr, space = true, enter = true
        }
      end

      -- @module 'blink.pairs'
      -- @type blink.pairs.Config
      local opts = {
        mappings = {
          -- you can call require("blink.pairs.mappings").enable() and require("blink.pairs.mappings").disable() to enable/disable mappings at runtime
          enabled = true,
          -- see the defaults: https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L10
          pairs = {
            ['!'] = { { '<!--', '-->', filetypes = { 'html', 'markdown' } } },
            ['('] =  makePair(')'),
            ['['] = makePair(']'),
            ['{'] = makePair('}'),
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
      }

      blnkp.setup(opts)
    end
  },
}
