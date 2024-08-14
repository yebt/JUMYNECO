---------------------------------------------
--- Plugins for colors
---------------------------------------------

local clrchm = 'kanagawa' --- kanagawa, tokyonight, flow, nordic, onedarkpro, moonfly, dracula, night-owl, monokai-pro

function is_color(plug)
  return plug.name == clrchm
end

return {
  --- Kanagawa
  {
    'rebelot/kanagawa.nvim',
    name = 'kanagawa',
    cond = is_color,
    priority = 1000,
    event = 'VeryLazy',
    config = require('plugins.configs.kanagawac'),
  },

  --- Tokionight
  {
    'folke/tokyonight.nvim',
    name = 'tokyonight',
    cond = is_color,
    event = 'VeryLazy',
    priority = 1000,
    config = require('plugins.configs.tokyonightc'),
  },

  --- Flow
  {
    '0xstepit/flow.nvim',
    name = 'flow',
    cond = is_color,
    event = 'VeryLazy',
    priority = 1000,
    config = require('plugins.configs.flowc'),
  },

  --- Nordic
  {
    'AlexvZyl/nordic.nvim',
    name = 'nordic',
    cond = is_color,
    event = 'VeryLazy',
    priority = 1000,
    config = require('plugins.configs.nordic'),
  },

  --- onedarkpro
  {
    'olimorris/onedarkpro.nvim',
    name = 'onedarkpro',
    cond = is_color,
    event = 'VeryLazy',
    priority = 1000,
    config = require('plugins.configs.onedarkproc'),
  },

  --- moonfly
  {
    'bluz71/vim-moonfly-colors',
    name = 'moonfly',
    cond = is_color,
    event = 'VeryLazy',
    priority = 1000,
    config = require('plugins.configs.moonflyc'),
  },

  --- Dracula
  {
    'dracula/vim',
    name = 'dracula',
    cond = is_color,
    event = 'VeryLazy',
    priority = 1000,
    config = function()
      vim.cmd('colorscheme dracula')
    end,
  },

  --- Night Owl
  {
    'oxfist/night-owl.nvim',
    name = 'night-owl',
    cond = is_color,
    event = 'VeryLazy',
    priority = 1000,
    config = require('plugins.configs.night-owlc'),
  },

  --- Monokai pro
  {
    'loctvl842/monokai-pro.nvim',
    name = 'monokai-pro',
    cond = is_color,
    event = 'VeryLazy',
    priority = 1000,
    config = require('plugins.configs.monokai-proc'),
  },
}
