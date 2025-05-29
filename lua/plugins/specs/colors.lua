--- COLORS THINGS
--- Just the colors things
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
        local ca = "#76946A"
        local cc = "#DCA561"
        local cd = "#C34043"

        h.MiniStarterFooter = { link = 'Comment' }

        h.MiniDiffOverAdd     = "DiffAdd"
        h.MiniDiffOverChange  = "DiffText"
        h.MiniDiffOverContext = "DiffChange"
        h.MiniDiffOverDelete  = "DiffDelete"

        h.MiniDiffSignAdd     = { fg = ca }
        h.MiniDiffSignChange  = { fg = cc }
        h.MiniDiffSignDelete  = { fg = cd }

        h.GitSignsAdd         = { fg = ca}
        h.GitSignsChange      = { fg = cc}
        h.GitSignsDelete      = { fg = cd}

      end,
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd.colorscheme('tokyonight')
    end,
  },
}
