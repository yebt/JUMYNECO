---------------------------------------------
--- Plugins add git iterations support
---------------------------------------------

return {

  --- Client iterations
  {
    'echasnovski/mini-git',
    version = false,
    main = 'mini.git',
    cmd = { 'Git' },
    event = { 'VeryLazy' },
    config = require('plugins.configs.minigitc'),
  },

  --- Diffs
  {
    'echasnovski/mini.diff',
    version = false,
    event = { 'VeryLazy' },
    config = require('plugins.configs.minidiffc'),
  },
}
