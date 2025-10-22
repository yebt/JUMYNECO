--- #ababab
--- COLORS THINGS
--- Just the colors things
-- 'tokyonight.nvim', 'slack.nvim'
-- local color = 'tokyonight.nvim'
-- local color = 'yoda.nvim'
-- local color = 'oasis.nvim'
-- local color = 'finale-nvim'
local color = 'gruvbox.nvim'

local function isColor(plgn)
  return plgn.name == color
end

return {
  --- 'oasis'
  {
    "uhs-robert/oasis.nvim",
    -- event = { "VeryLazy" },
    --- Lagon, abyss, midnight, night, starlight, twilight
    cond = isColor,
    lazy = false,
    priority = 1000,
    config = function()
      require('oasis').setup({
        style = "lagoon", -- Optional: Choose any style like `lagoon` or 'dune'.
      })
    end
  },

  -- Finale : *****
  {
    "https://gitlab.com/bartekjaszczak/finale-nvim",
    event = { "VeryLazy" },
    cond = isColor,
    priority = 10000,
    opts = {
      styles = {
        -- These are the default styles
        comments = {
          bold = false,
          italic = true,
        },
        statements = {
          bold = true,
          italic = false,
        }, -- Statements that are NOT keywords + preproc statements (include, define) but NOT macros
        keywords = {
          bold = true,
          italic = false,
        },
        operators = {
          bold = false,
          italic = false,
        },
      },
      colour_overrides = {
        -- suggestions = "#FFFFFF", -- Copilot inline suggestions
        --
        -- syntax = {
        --     text = "#FFFFFF",            -- Normal text
        --     comment = "#FFFFFF",
        --     comment_special = "#FFFFFF", -- Documentation comments
        --
        --     string = "#FFFFFF",          -- String literals
        --     char = "#FFFFFF",            -- Character literals
        --     stringspecial = "#FFFFFF",   -- Regex, escape characters and other special parts of the string
        --
        --     constant = "#FFFFFF",        -- Constant literals
        --     enummember = "#FFFFFF",
        --
        --     number = "#FFFFFF",    -- Number literals
        --     boolean = "#FFFFFF",   -- Boolean literals
        --
        --     variable = "#FFFFFF",  -- Normal variables
        --     param = "#FFFFFF",     -- Function parameters
        --     field = "#FFFFFF",     -- Member variables, properties
        --     global = "#FFFFFF",    -- Global variables
        --     static = "#FFFFFF",    -- Static variables
        --     builtin = "#FFFFFF", -- Built in variables
        --
        --     func = "#FFFFFF",      -- Functions
        --     method = "#FFFFFF",    -- Methods
        --
        --     statement = "#FFFFFF", -- Statements (usually overridden by another highlight groups, such as keywords, operators, labels, etc.)
        --     keyword = "#FFFFFF",
        --     keyword_flow = "#FFFFFF", -- Keywords related to execution flow, such as conditionals (if, else), loops (for, while), break, continue, goto, etc.
        --     operator = "#FFFFFF",
        --
        --     preproc = "#FFFFFF", -- Preprocessor directives
        --
        --     type = "#FFFFFF", -- Types
        --     type_builtin = "#FFFFFF", -- Built in types, such as int, float, bool (depends on the language)
        --
        --     special = "#FFFFFF", -- Special punctuation, parts of comments, special characters in a string, matching parenthesis
        --
        --     debug = "#FFFFFF", -- Debugging statements
        --     error = "#FFFFFF", -- Errors
        --
        --     bracket = "#FFFFFF", -- Brackets: (), {}, []
        --     delimiter = "#FFFFFF", -- Operators such as: +, *, =, sizeof (C/C++), etc.
        --
        --     label = "#FFFFFF", -- Labels (cases, default)
        --     namespace = "#FFFFFF",
        --     module = "#FFFFFF",
        --     tag = "#FFFFFF",
        --     attribute = "#FFFFFF",
        --
        --     h1 = "#FFFFFF", -- Headers (HTML, markup, documentation)
        --     h2 = "#FFFFFF",
        --     h3 = "#FFFFFF",
        --     h4 = "#FFFFFF",
        --     h5 = "#FFFFFF",
        --     h6 = "#FFFFFF",
        --     link = "#FFFFFF", -- Links in HTML, markdown, text
        -- },
      },
    },
    config = function(_, opts)
      require("finale").setup(opts)
      -- Activate the theme
      vim.cmd.colorscheme("finale")
    end
  },

  -- lua/plugins/gruvbox.lua
  {
    "https://gitlab.com/motaz-shokry/gruvbox.nvim",
    name = "gruvbox.nvim",
    -- event = { "VeryLazy" },
    cond = isColor,
    lazy = false,
    priority = 10000,
    opts = {
      variant = "hard",      -- hard, medium, soft, light
      dark_variant = "medium", -- hard, medium, soft
      dim_inactive_windows = true,
      extend_background_behind_borders = true,
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)
      vim.cmd("colorscheme gruvbox")
    end
  },

  -- Yoda
  {
    "kuri-sun/yoda.nvim",
    -- event = { "VeryLazy" },
    lazy = false,
    priority = 1000,
    cond = isColor,
    opts = {},
    config = function(_, opts)
      vim.cmd.colorscheme('yoda')
    end,
  },

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
      dimInactive = true,
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
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
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

  --- https://github.com/loctvl842/monokai-pro.nvim
}
