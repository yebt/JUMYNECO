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
      -- on_highlights = function(highlights, colors)

      on_highlights = function(h, c)
        h.MiniStarterFooter = { link = 'Comment' }
        h.MiniDiffOverAdd     = "DiffAdd"
        h.MiniDiffOverChange  = "DiffText"
        h.MiniDiffOverContext = "DiffChange"
        h.MiniDiffOverDelete  = "DiffDelete"
        h.MiniDiffSignAdd     = { fg = "#76946A" }
        h.MiniDiffSignChange  = { fg = "#DCA561" }
        h.MiniDiffSignDelete  = { fg = "#C34043" }
      end,
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd.colorscheme('tokyonight')
    end,
  },
}
