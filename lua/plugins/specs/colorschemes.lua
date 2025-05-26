--- Colorschemes
return {

  --- Tokyonight
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'night',
      dim_inactive = true,
      on_colors = function(colors) end,
      on_highlights = function(highlights, colors)
        highlights.MiniStarterFooter = { link = 'Comment' }
      end,
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd.colorscheme('tokyonight')
    end,
  },
}
