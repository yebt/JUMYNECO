-- local color = 'night-owl.nvim'
-- local color = 'vitesse.nvim'
-- local color = 'newpaper.nvim'
-- local color = 'hyper.nvim'
-- local color = 'obscure.nvim'
-- local color = 'aquarium-vim'
-- local color = 'monokai-pro.nvim'
-- local color = 'onedarkpro.nvim'
-- local color = 'nvimgelion'
-- local color = 'one_monokai.nvim'
-- local color = 'midnight.nvim'
-- local color = 'oxocarbon.nvim'
-- local color = 'github-theme'
-- local color = 'nightfox.nvim'
-- local color = 'finale.nvim'
-- local color = 'luma.nvim'
--
-- local color = 'obscure.nvim'
-- local color = 'porcelain.nvim'
local color = 'monokai-nightasty.nvim'
-- local color = 'ronny.nvim'
-- local color = 'alduin.nvim'
-- local color = 'nordic.nvim'
-- local color = 'onedark.nvim'

--- check if the plugin is the color you want
local isColor = function(plugin)
  return plugin.name == color
end

return {

  --- Night Owl
  {
    'oxfist/night-owl.nvim',
    cond = isColor,
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      require('night-owl').setup()
      vim.cmd.colorscheme('night-owl')
    end,
  },

  --- Obscure
  {
    'killitar/obscure.nvim',
    lazy = false,
    priority = 1000,
    cond = isColor,
    opts = {
      transparent = false,
      terminal_colors = true,
      dim_inactive = true,
      styles = {
        keywords = { italic = true },
        identifiers = {},
        functions = {},
        variables = {},
        booleans = {},
        comments = { italic = true },
      },

      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      on_highlights = function(highlights, colors) end,

      plugins = {
        -- enable all plugins when not using lazy.nvim
        -- set to false to manually enable/disable plugins
        all = package.loaded.lazy == nil,
        -- uses your plugin manager to automatically enable needed plugins
        -- currently only lazy.nvim is supported
        auto = true,
        -- add any plugins here that you want to enable
        -- for all possible plugins, see:
        --   * https://github.com/killitar/obscure.nvim/tree/main/lua/obscure/groups
        -- flash = true,
      },
    },
    config = function(_, opts)
      require('obscure').setup(opts)
      vim.cmd.colorscheme('obscure')
    end,
  },

  --- Porcelain
  {
    'nvimdev/porcelain.nvim',
    lazy = false,
    priority = 1000,
    cond = isColor,
    config = function()
      vim.cmd.colorscheme('porcelain')
      --- Fix some color problems
      -- vim.cmd.highlight('NormalFloat', 'guibg=NONE')
      vim.cmd.highlight('IndentLine guifg=#123456')
      vim.cmd.highlight('IndentLineCurrent guifg=#125750')
      vim.cmd.highlight('FoldColumn guifg=#666A62')
      vim.cmd.highlight('LspReferenceText guibg=#1F282E gui=underline')
    end,
  },

  --- Vitesse
  {
    '2nthony/vitesse.nvim',
    dependencies = {
      'tjdevries/colorbuddy.nvim',
    },
    lazy = false,
    priority = 1000,
    cond = isColor,
    opts = {
      comment_italics = true,
      transparent_background = false,
      transparent_float_background = false, -- aka pum(popup menu) background
      reverse_visual = false,
      dim_nc = false,
      cmp_cmdline_disable_search_highlight_group = true, -- disable search highlight group for cmp item
      -- if `transparent_float_background` false, make telescope border color same as float background
      telescope_border_follow_float_background = false,
      -- similar to above, but for lspsaga
      lspsaga_border_follow_float_background = false,
      -- diagnostic virtual text background, like error lens
      diagnostic_virtual_text_background = false,

      -- override the `lua/vitesse/palette.lua`, go to file see fields
      colors = {},
      themes = {},
    },
    config = function(_, opts)
      require('vitesse').setup(opts)
      vim.cmd.colorscheme('vitesse')
    end,
  },

  --- Colorbuddy
  {
    'yorik1984/newpaper.nvim',
    lazy = false,
    priority = 1000,
    cond = isColor,
    opts = {
      style = 'dark',
      lightness = 0.1,
      saturation = 0.5,
      -- "lightness", "average", "luminosity"
      greyscale = false,
      -- "bg", "contrast", "inverse", "inverse_transparent"
      terminal = 'contrast',
      sidebars_contrast = { 'NvimTree', 'vista_kind', 'Trouble' },
      delim_rainbow_bold = true,
    },
  },

  --- Hyper
  {
    'paulo-granthon/hyper.nvim',
    lazy = false,
    priority = 1000,
    cond = isColor,
    config = function()
      require('hyper').load()
    end,
  },

  --- Alduin
  {
    'bakageddy/alduin.nvim',
    lazy = false,
    priority = 1000,
    cond = isColor,
    opts = {
      terminal_colors = true, -- add neovim terminal colors
      inverse = true, -- invert background for search, diffs, statuslines and errors
      palette_overrides = {},
      overrides = {},
    },
    config = function(_, opts)
      require('alduin').setup(opts)
      vim.cmd.colorscheme('alduin')
    end,
  },

  --- Obscure
  {
    'killitar/obscure.nvim',
    lazy = false,
    priority = 1000,
    cond = isColor,
    opts = {
      transparent = false,
      terminal_colors = true,
      dim_inactive = true,
      keywords = { italic = true },
      identifiers = {},
      functions = {},
      variables = {},
      booleans = {},
      comments = { italic = true },
    },
    config = function(_, opts)
      require('obscure').setup(opts)
      vim.cmd.colorscheme('obscure')
    end,
  },

  --- Monokai nightastic
  {
    'polirritmico/monokai-nightasty.nvim',
    lazy = false,
    priority = 1000,
    cond = isColor,
    opts = {
      dim_inactive = true,
    },
    config = function(_, opts)
      require('monokai-nightasty').setup(opts)
      vim.cmd.colorscheme('monokai-nightasty')
      vim.cmd.highlight('IndentLine guifg=#123456')
      vim.cmd.highlight('IndentLineCurrent guifg=#125750')
      vim.cmd.highlight('FoldColumn guifg=#666A62')
      -- vim.cmd.highlight('LspReferenceText guibg=#1F282E gui=underline')
    end,
  },

  --- ronny
  {
    'judaew/ronny.nvim',
    lazy = false,
    priority = 1000,
    cond = isColor,
    opts = {},
    config = function(_, opts)
      require('ronny').setup(opts)
      vim.cmd.colorscheme('ronny')
    end,
  },

  --- Aquarium
  {
    'FrenzyExists/aquarium-vim',
    lazy = false,
    priority = 1000,
    cond = isColor,
    config = function()
      -- vim.opt.background = 'light'
      -- vim.g.aquarium_style= 'light'
      vim.cmd.colorscheme('aquarium')
    end,
  },

  --- monokai-pro
  {
    'loctvl842/monokai-pro.nvim',
    lazy = false,
    priority = 1000,
    cond = isColor,
    opts = {
      transparent_background = false,
      terminal_colors = true,
      devicons = true, -- highlight the icons of `nvim-web-devicons`
      styles = {
        comment = { italic = true },
        keyword = { italic = true }, -- any other keyword
        type = { italic = true }, -- (preferred) int, long, char, etc
        storageclass = { italic = true }, -- static, register, volatile, etc
        structure = { italic = true }, -- struct, union, enum, etc
        parameter = { italic = true }, -- parameter pass in function
        annotation = { italic = true },
        tag_attribute = { italic = true }, -- attribute of tag in reactjs
      },
      -- classic | octagon | pro | machine | ristretto | spectrum
      filter = 'spectrum',
      -- Enable this will disable filter option
      day_night = {
        enable = false, -- turn off by default
        day_filter = 'pro', -- classic | octagon | pro | machine | ristretto | spectrum
        night_filter = 'spectrum', -- classic | octagon | pro | machine | ristretto | spectrum
      },
      inc_search = 'background', -- underline | background
      background_clear = {
        -- "float_win",
        'toggleterm',
        'telescope',
        -- "which-key",
        'renamer',
        -- 'notify',
        -- "nvim-tree",
        -- "neo-tree",
        -- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
      }, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
      plugins = {
        bufferline = {
          underline_selected = false,
          underline_visible = false,
        },
        indent_blankline = {
          context_highlight = 'default', -- default | pro
          context_start_underline = false,
        },
      },
    },
    config = function(_, opts)
      require('monokai-pro').setup(opts)
      vim.cmd.colorscheme('monokai-pro')
    end,
  },

  --- onedarkpro
  {
    'olimorris/onedarkpro.nvim',
    lazy = false,
    priority = 1000,
    cond = isColor,
    opts = {},
    config = function(_, opts)
      require('onedarkpro').setup(opts)
      vim.cmd.colorscheme('onedark_dark')
    end,
  },

  --- nvimgelion
  {
    'nyngwang/nvimgelion',
    lazy = false,
    priority = 1000,
    cond = isColor,
    config = function()
      vim.cmd.colorscheme('nvimgelion')
    end,
  },

  --- one_monokai
  {
    'cpea2506/one_monokai.nvim',
    lazy = false,
    priority = 1000,
    cond = isColor,
    opts = {
      colors = {
        -- bg = '#282c34',
        bg = '#161819',
      },
      -- transparent = true,
    },
    config = function(_, opts)
      require('one_monokai').setup(opts)
      vim.cmd.colorscheme('one_monokai')
    end,
  },

  --- midnight
  {
    'dasupradyumna/midnight.nvim',
    lazy = false,
    priority = 1000,
    cond = isColor,
    opts = {},
    config = function(_, opts)
      require('midnight').setup(opts)
      vim.cmd.colorscheme('midnight')
    end,
  },

  --- oxocarbon
  {
    'nyoom-engineering/oxocarbon.nvim',
    lazy = false,
    priority = 1000,
    cond = isColor,
    config = function()
      vim.cmd.colorscheme('oxocarbon')
      vim.cmd.highlight('IndentLine guifg=#20302C')
      -- vim.cmd.highlight('IndentLineCurrent guifg=#F9CB40')
      -- vim.cmd.highlight('IndentLineCurrent guifg=#698210')
      vim.cmd.highlight('IndentLineCurrent guifg=#597D4A')
    end,
  },

  --- github-nvim-theme
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,
    priority = 1000,
    cond = isColor,
    opts = {
      options = {
        -- Compiled file's destination location
        compile_path = vim.fn.stdpath('cache') .. '/github-theme',
        compile_file_suffix = '_compiled', -- Compiled file suffix
        hide_end_of_buffer = false, -- Hide the '~' character at the end of the buffer for a cleaner look
        hide_nc_statusline = false, -- Override the underline style for non-active statuslines
        transparent = false, -- Disable setting bg (make neovim's background transparent)
        terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
        dim_inactive = false, -- Non focused panes set to alternative background
        module_default = true, -- Default enable value for modules
        styles = { -- Style to be applied to different syntax groups
          comments = 'italic', -- Value is any valid attr-list value `:help attr-list`
          functions = 'NONE',
          keywords = 'NONE',
          variables = 'NONE',
          conditionals = 'NONE',
          constants = 'NONE',
          numbers = 'NONE',
          operators = 'NONE',
          strings = 'NONE',
          types = 'NONE',
        },
        inverse = { -- Inverse highlight for different types
          match_paren = true,
          visual = true,
          search = true,
        },
        darken = { -- Darken floating windows and sidebar-like windows
          floats = true,
          sidebars = {
            enable = true,
            list = {}, -- Apply dark background to specific windows
          },
        },
        modules = { -- List of various plugins and additional options
          -- ...
        },
      },
      palettes = {},
      specs = {},
      groups = {},
    },
    config = function(_, opts)
      require('github-theme').setup(opts)
      vim.cmd.colorscheme('github_dark_high_contrast')
    end,
  },

  --- onedark nvim
  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    cond = isColor,
    opts = {
      -- Main options --
      style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      transparent = false, -- Show/hide background
      term_colors = true, -- Change terminal color as per the selected theme style
      ending_tildes = true, -- Show the end-of-buffer tildes. By default they are hidden
      cmp_itemkind_reverse = true, -- reverse item kind highlights in cmp menu

      -- toggle theme style ---
      toggle_style_key = '<leader>tt', -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
      toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

      -- Change code style ---
      -- Options are italic, bold, underline, none
      -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
      code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none',
      },

      -- Lualine options --
      lualine = {
        transparent = false, -- lualine center bar transparency
      },

      -- Custom Highlights --
      colors = {}, -- Override default colors
      highlights = {}, -- Override highlight groups

      -- Plugins Config --
      diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true, -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
      },
    },
    config = function(_, opts)
      require('onedark').setup(opts)
      -- vim.cmd.colorscheme('onedark')
      require('onedark').load()
    end,
  },

  --- nodic.nvim
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    cond = isColor,
    opts = {
      -- This callback can be used to override the colors used in the base palette.
      on_palette = function(palette) end,
      -- This callback can be used to override the colors used in the extended palette.
      after_palette = function(palette) end,
      -- This callback can be used to override highlights before they are applied.
      on_highlight = function(highlights, palette) end,
      -- Enable bold keywords.
      bold_keywords = true,
      -- Enable italic comments.
      italic_comments = true,
      -- Enable editor background transparency.
      transparent = {
        -- Enable transparent background.
        bg = false,
        -- Enable transparent background for floating windows.
        float = false,
      },
      -- Enable brighter float border.
      bright_border = false,
      -- Reduce the overall amount of blue in the theme (diverges from base Nord).
      reduced_blue = true,
      -- Swap the dark background with the normal one.
      swap_backgrounds = false,
      -- Cursorline options.  Also includes visual/selection.
      cursorline = {
        -- Bold font in cursorline.
        bold = false,
        -- Bold cursorline number.
        bold_number = true,
        -- Available styles: 'dark', 'light'.
        theme = 'dark',
        -- Blending the cursorline bg with the buffer bg.
        blend = 0.85,
      },
      noice = {
        -- Available styles: `classic`, `flat`.
        style = 'classic',
      },
      telescope = {
        -- Available styles: `classic`, `flat`.
        style = 'flat',
      },
      leap = {
        -- Dims the backdrop when using leap.
        dim_backdrop = false,
      },
      ts_context = {
        -- Enables dark background for treesitter-context window
        dark_background = true,
      },
    },
    config = function(_, opts)
      local nrd = require('nordic')
      nrd.setup(opts)
      nrd.load()
    end,
  },

  --- Night fox
  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    cond = isColor,
    lazy = false,
    opts = {
      options = {
        -- Compiled file's destination location
        compile_path = vim.fn.stdpath('cache') .. '/nightfox',
        compile_file_suffix = '_compiled', -- Compiled file suffix
        transparent = false, -- Disable setting background
        terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
        dim_inactive = false, -- Non focused panes set to alternative background
        module_default = true, -- Default enable value for modules
        colorblind = {
          enable = false, -- Enable colorblind support
          simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
          severity = {
            protan = 0, -- Severity [0,1] for protan (red)
            deutan = 0, -- Severity [0,1] for deutan (green)
            tritan = 0, -- Severity [0,1] for tritan (blue)
          },
        },
        styles = { -- Style to be applied to different syntax groups
          comments = 'NONE', -- Value is any valid attr-list value `:help attr-list`
          conditionals = 'NONE',
          constants = 'NONE',
          functions = 'NONE',
          keywords = 'NONE',
          numbers = 'NONE',
          operators = 'NONE',
          strings = 'NONE',
          types = 'NONE',
          variables = 'NONE',
        },
        inverse = { -- Inverse highlight for different types
          match_paren = false,
          visual = false,
          search = false,
        },
        modules = { -- List of various plugins and additional options
          -- ...
        },
      },
      palettes = {},
      specs = {},
      groups = {},
    },
    config = function(_, opts)
      require('nightfox').setup(opts)
      vim.cmd.colorscheme('carbonfox')
    end,
  },

  {
    'https://gitlab.com/bartekjaszczak/finale-nvim',
    name = 'finale.nvim',
    lazy = false,
    cond = isColor,
    priority = 1000,
    config = function()
      -- Activate the theme
      vim.cmd.colorscheme('finale')
    end,
  },

  {
    'https://gitlab.com/bartekjaszczak/luma-nvim',
    name = 'luma.nvim',
    priority = 1000,
    lazy = false,
    cond = isColor,
    config = function()
      require('luma').setup({
        theme = 'dark', -- "dark" or "light" theme
        contrast = 'medium', -- "low", "medium" or "high" contrast
      })

      -- Activate the theme
      vim.cmd.colorscheme('luma')
    end,
  },
}
