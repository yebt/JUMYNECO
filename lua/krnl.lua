--- bootstrap all settings


local without_args = vim.fn.argc(-1) == 0

--- leaders
vim.g.mapleader = ' '
vim.g.maplocal = ' '


--- Load options
require('config.options')
--- Load maps
require('config.keymaps')
if not without_args then
--- Load autocmds
require('config.autocmds')
end


--- Event for lazy.nvim
vim.api.nvim_create_autocmd('User', {
  group = group,
  pattern = 'VeryLazy',
  callback = function()
    if without_args then
      require('config.autocmds')
    end
    vim.schedule(function()
      vim.api.nvim_exec_autocmds("FileType", {})
    end)
  end,
})

--- lazy
require('config.lazy')
