------------------------------
-- ░█░░░█▀█░▀█▀░█░█░█▀▀
-- ░█░░░█░█░░█░░█░█░▀▀█
-- ░▀▀▀░▀▀▀░░▀░░▀▀▀░▀▀▀
--- Lotus nvim by: yebt
------------------------------

-- Allow experimental loading
vim.loader.enable()

--- Flag
local lazy_autocmds = vim.fn.argc(-1) == 0

-- Set leaders
vim.g.mapleader = vim.keycode('<space>')
vim.g.maplocal = vim.keycode('<space>')

-- Base
require("configs.options")
require("configs.strive")

if not lazy_autocmds then
  require("configs.aus")
end

--- NOTE: event User StriveDone
vim.api.nvim_create_autocmd('User',{
  group = vim.api.nvim_create_augroup('StrivePostLoad', { clear = false }),
  once = true,
  callback = function()
    if lazy_autocmds then
      require("configs.aus")
    end
    require("configs.kmps")
  end,
  desc="Actios after load strive"
})

