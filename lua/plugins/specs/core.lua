---------------------------------------------
--- Plugins needed always
---------------------------------------------

return {
  --- Hard time for make a better practice and usage
  {
    'm4xshen/hardtime.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    lazy = false,
    config = require('plugins.configs.hardtimec'),
  },

  --- Treesitter
}
