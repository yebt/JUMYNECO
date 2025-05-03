return {
  -- Kanagawa
  {
    "rebelot/kanagawa.nvim",
    -- event = "VeryLazy",
    -- priority = -1,
    lazy = false,
    opts = {
      compile = true,   -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = { bold = true, },
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,   -- do not set background color
      dimInactive = true,    -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = {             -- add/modify theme and palette colors
        palette = {
          -- sumiInk0 = "#000000",
          -- fujiWhite = "#FFFFFF",
        },
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors) -- add/modify highlights
        local theme = colors.theme
        local palette = colors.palette

        local makeDiagnosticColor = function(color)
          local c = require("kanagawa.lib.color")
          return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
        end

        local itemMode = 'fg'
        local useBg = false
        local makeItemColor = function(color)
          local newColor = { fg = color.fg }
          if useBg then
            newColor.bg = color.bg
          else
            newColor.bg = "NONE"
          end
          if itemMode == 'fg' then
            return newColor
          end
          return { bg = newColor.fg, fg = newColor.bg }
        end
        return {
          --- transparent floating
          -- NormalFloat                = { bg = "none" },
          -- FloatBorder                = { bg = "none" },
          -- FloatTitle                 = { bg = "none" },
          -- NormalDark                 = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          -- LazyNormal                 = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          -- MasonNormal                = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

          --- Diagnostics
          DiagnosticVirtualTextHint  = makeDiagnosticColor(theme.diag.hint),
          DiagnosticVirtualTextInfo  = makeDiagnosticColor(theme.diag.info),
          DiagnosticVirtualTextWarn  = makeDiagnosticColor(theme.diag.warning),
          DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),

          --- Dark completion
          Pmenu                      = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel                   = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar                  = { bg = palette.surimiOrange },
          PmenuThumb                 = { bg = theme.ui.bg_p2 },

          --- indentline
          IndentLine                 = { fg = theme.ui.bg_p2 },
          IndentLineCurrent          = { fg = palette.roninYellow },

          --- Cmp Types


          BlinkCmpKindField         = makeItemColor { bg = '#EED8DA', fg = '#B5585F' },
          BlinkCmpKindProperty      = makeItemColor { bg = '#EED8DA', fg = '#B5585F' },
          BlinkCmpKindEvent         = makeItemColor { bg = '#EED8DA', fg = '#B5585F' },
          BlinkCmpKindText          = makeItemColor { bg = '#C3E88D', fg = '#9FBD73' },
          BlinkCmpKindEnum          = makeItemColor { bg = '#C3E88D', fg = '#9FBD73' },
          BlinkCmpKindKeyword       = makeItemColor { bg = '#C3E88D', fg = '#9FBD73' },
          BlinkCmpKindConstant      = makeItemColor { bg = '#FFE082', fg = '#D4BB6C' },
          BlinkCmpKindConstructor   = makeItemColor { bg = '#FFE082', fg = '#D4BB6C' },
          BlinkCmpKindReference     = makeItemColor { bg = '#FFE082', fg = '#D4BB6C' },
          BlinkCmpKindFunction      = makeItemColor { bg = '#EADFF0', fg = '#A377BF' },
          BlinkCmpKindStruct        = makeItemColor { bg = '#EADFF0', fg = '#A377BF' },
          BlinkCmpKindClass         = makeItemColor { bg = '#EADFF0', fg = '#A377BF' },
          BlinkCmpKindModule        = makeItemColor { bg = '#EADFF0', fg = '#A377BF' },
          BlinkCmpKindOperator      = makeItemColor { bg = '#EADFF0', fg = '#A377BF' },
          BlinkCmpKindVariable      = makeItemColor { bg = '#C5CDD9', fg = '#7E8294' },
          BlinkCmpKindFile          = makeItemColor { bg = '#C5CDD9', fg = '#7E8294' },
          BlinkCmpKindUnit          = makeItemColor { bg = '#F5EBD9', fg = '#D4A959' },
          BlinkCmpKindSnippet       = makeItemColor { bg = '#F5EBD9', fg = '#D4A959' },
          BlinkCmpKindFolder        = makeItemColor { bg = '#F5EBD9', fg = '#D4A959' },
          BlinkCmpKindMethod        = makeItemColor { bg = '#DDE5F5', fg = '#6C8ED4' },
          BlinkCmpKindValue         = makeItemColor { bg = '#DDE5F5', fg = '#6C8ED4' },
          BlinkCmpKindEnumMember    = makeItemColor { bg = '#DDE5F5', fg = '#6C8ED4' },
          BlinkCmpKindInterface     = makeItemColor { bg = '#D8EEEB', fg = '#58B5A8' },
          BlinkCmpKindColor         = makeItemColor { bg = '#D8EEEB', fg = '#58B5A8' },
          BlinkCmpKindTypeParameter = makeItemColor { bg = '#D8EEEB', fg = '#58B5A8' },
        }
      end,
      theme = "wave",  -- Load "wave" theme
      background = {   -- map the value of 'background' option to a theme
        dark = "wave", -- try "dragon" !
        light = "lotus"
      },
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd.colorscheme("kanagawa")
    end

  }
}
