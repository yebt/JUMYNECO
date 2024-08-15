---------------------------------------------
--- Plugins used for make a better ui
---------------------------------------------

return {
  --- Notifycations
  {
    'echasnovski/mini.notify',
    version = false,
    event = { 'VeryLazy' },
    config = require('plugins.configs.mininotifyc'),
  },

  --- Statusline mini
  {
    'echasnovski/mini.statusline',
    version = false,
    event = { 'VeryLazy' },
    init = function()
      vim.opt.statusline = ''
    end,
    config = require('plugins.configs.ministatuslinec'),
  },
}
