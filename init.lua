------------------------------
-- ░█░░░█▀█░▀█▀░█░█░█▀▀
-- ░█░░░█░█░░█░░█░█░▀▀█
-- ░▀▀▀░▀▀▀░░▀░░▀▀▀░▀▀▀
--- Lotus nvim by: yebt
------------------------------

require('config.options')

vim.g.mapleader = vim.keycode('<space>')
vim.g.maplocal = vim.keycode('<space>')

--- Lazy autocmds
local lazy_autocmds = vim.fn.argc(-1) == 0
if not lazy_autocmds then
  require('config.autocmds')
end

--- Action on lazyload
vim.api.nvim_create_autocmd('User', {
  group = vim.api.nvim_create_augroup('LunarSetup', { clear = true }),
  pattern = 'VeryLazy',
  callback = function()
    if lazy_autocmds then
      require('config.autocmds')
    end
    -- laod keymaps
    require('config.kmaps')
    -- lsp configs local
    require('config.lspl')
  end,
})

-- vim.api.nvim_create_autocmd('User', {
--   pattern="LazyFile",
--   callback = function()
--     vim.print("LF")
--   end
-- })

--- UIEnter occource before that lazy
-- vim.api.nvim_create_autocmd('UIEnter', {
--   callback = function()
--   end
-- })

require('config.lazy')
