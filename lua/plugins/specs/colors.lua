--- #ababab
--- COLORS THINGS
--- Just the colors things
-- 'tokyonight.nvim', 'slack.nvim'
local color = 'tokyonight.nvim'

local function isColor(plgn)
  return plgn.name == color
end

return {

  --- Tokyonight
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    cond = isColor,
    -- event = 'VeryLazy',
    opts = {
      style = 'night',
      dim_inactive = true,
      on_colors = function(colors) end,
      -- on_highlights = function(highlights, colors)

      on_highlights = function(h, c)
        local ca = '#76946A'
        local cc = '#DCA561'
        local cd = '#C34043'

        h.MiniStarterFooter = { link = 'Comment' }

        h.MiniDiffOverAdd = 'DiffAdd'
        h.MiniDiffOverChange = 'DiffText'
        h.MiniDiffOverContext = 'DiffChange'
        h.MiniDiffOverDelete = 'DiffDelete'

        h.MiniDiffSignAdd = { fg = ca }
        h.MiniDiffSignChange = { fg = cc }
        h.MiniDiffSignDelete = { fg = cd }

        h.GitSignsAdd = { fg = ca }
        h.GitSignsChange = { fg = cc }
        h.GitSignsDelete = { fg = cd }
      end,
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd.colorscheme('tokyonight')
    end,
  },

  --- Snack
  {
    'ntk148v/slack.nvim',
    -- lazy = false,
    -- priority = 1000,
    -- cond = isColor,
    config = function()
      vim.cmd.colorscheme('slack')
    end,
  },

  ---
  {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup({
        style = 'warmer', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      })
      -- Enable theme
      require('onedark').load()
    end,
  },

  ---
  {
    'ribru17/bamboo.nvim',
    config = function()
      require('bamboo').setup({
        -- optional configuration here
        toggle_style_key = '<leader>ts',
        style = 'vulgaris', -- Choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
        ending_tildes = true,
      })
      require('bamboo').load()
    end,
  },

  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      variant = 'default',
      italic_comments = true,
    },
  },

  {
    'rebelot/kanagawa.nvim',
    opts = {
      compile = true,
      theme = 'dragon',
      colors = {
        wave = {
          ui = {
            float = {
              bg = 'none',
            },
          },
        },
        dragon = {
          syn = {
            parameter = 'yellow',
          },
        },
        all = {
          ui = {
            bg_gutter = 'none',
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },  -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
        }
      end,
    },
  },

  --- Colorize
  {
    'echasnovski/mini.hipatterns',
    version = false,
    event = 'VeryLazy',
    -- opts = {}
    config = function()
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          -- -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          -- fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          -- hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
          -- todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
          -- note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },
          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },
}
