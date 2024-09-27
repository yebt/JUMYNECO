-- local color = 'night-owl.nvim'
-- local color = 'obscure.nvim'
local color = 'porcelain.nvim'
-- local color = 'vitesse.nvim'
-- local color = 'newpaper.nvim'
-- local color = 'hyper.nvim'

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
}
