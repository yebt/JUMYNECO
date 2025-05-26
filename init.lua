------------------------------
-- ░█░░░█▀█░▀█▀░█░█░█▀▀
-- ░█░░░█░█░░█░░█░█░▀▀█
-- ░▀▀▀░▀▀▀░░▀░░▀▀▀░▀▀▀
--- Lotus nvim by: yebt
------------------------------

if vim.env.PROF then
  -- example for lazy.nvim
  -- change this to the correct path for your plugin manager
  local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
  vim.opt.rtp:append(snacks)
  require("snacks.profiler").startup({
    startup = {
      event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
      -- event = "UIEnter",
      -- event = "VeryLazy",
    },
  })
end

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
    vim.api.nvim_exec_autocmds('User',{
      pattern = 'PostVeryLazy'
    })
  end,
})

--- FIX: remove it:

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
--- Startup times for process: Primary (or UI client) ---

