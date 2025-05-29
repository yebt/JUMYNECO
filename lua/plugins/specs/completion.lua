return {

  --- blink cmp
  {
    'saghen/blink.cmp',
    dependencies = {
      --- Basic recs
      -- snippets
      'rafamadriz/friendly-snippets',
      -- icons to see
      'echasnovski/mini.icons',

      --- Comunity sources
      -- ripgrep
      "mikavilpas/blink-ripgrep.nvim",
    },
    event = { 'InsertEnter', 'VeryLazy' },
    -- lazy = false,
    -- version = 'v0.*', -- pre built binaries
    build = 'cargo build --release',
    config = function()
      local bcmp =  require("blink.cmp")
      local mi = require('mini.icons')

      local opts = {

        --- completion system with miniicons
        completion = {
          menu = {
            draw = {
              components = {
                kind_icon = {
                  text = function(ctx)
                    local kind_icon, _, _ = mi.get('lsp', ctx.kind)
                    return kind_icon
                  end,
                  -- (optional) use highlights from mini.icons
                  highlight = function(ctx)
                    local _, hl, _ = mi.get('lsp', ctx.kind)
                    return hl
                  end,
                },
                kind = {
                  -- (optional) use highlights from mini.icons
                  highlight = function(ctx)
                    local _, hl, _ = mi.get('lsp', ctx.kind)
                    return hl
                  end,
                }
              }
            }
          }
        }
      }
      bcmp.setup(opts)
    end
  },
}
