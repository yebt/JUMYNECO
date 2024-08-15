
return {

  --- Iterator
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    opts = {},
  },

  --- Sessions
  {
    'echasnovski/mini.sessions',
    version = false,
    init = require('plugins.inits.minisessionsi'),
    config = require('plugins.configs.minisessionsc'),
  },
}
