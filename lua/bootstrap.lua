---------------------------------------------
--- Starter Instructions
---------------------------------------------

--- If is init with a file
local without_args = vim.fn.argc(-1) == 0

--- Define leaders
vim.g.mapleader = ' '
vim.g.maplocalleader  = '\\'

--- Options
require("settings.options")

--- Keybindings
require("settings.keymaps")

--- Autocmds if is needed
if not without_args then
  require("settings.autocmds")
end

--- Event for plugin
vim.api.nvim_create_autocmd('User', {
  group = group,
  pattern = 'VeryLazy',
  callback = function()
    if without_args then
      require('configs.autocmds')
    end
  end,
})

--- Load plugins
require('plugins')
