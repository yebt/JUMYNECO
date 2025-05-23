return function(use)

--- Tokyonight
use 'folke/tokyonight.nvim'
  :setup({
    style = "night",
    dim_inactive = true,
    cache = true,
    on_highlights = function(hl,c)
      hl.MiniStarterFooter = {link = 'Comment'}
    end
  })
  -- :theme('tokyonight')
  :config(function()
    vim.cmd.colorscheme('tokyonight')
  end)
  :on('StriveDone')
  :load() -- load is more faster that theme

end
