---------------------------------------------
--- Starter Instructions
---------------------------------------------

--- If is init with a file
local without_args = vim.fn.argc(-1) == 0

--- Define leaders
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

--- Options
require('settings.options')

--- Keybindings
require('settings.keymaps')

--- Autocmds if is needed
if not without_args then
  require('settings.autocmds')
end

--- Event for plugin
vim.api.nvim_create_autocmd('User', {
  group = group,
  pattern = 'VeryLazy',
  callback = function()
    if without_args then
      require('settings.autocmds')
    end
  end,
})

-- vim.api.nvim_create_autocmd('BufReadPost', {
--   once = true,
--   callback = function(event)
--     -- Skip if we already entered vim
--     if vim.v.vim_did_enter == 1 then
--       return
--     end
--
--     -- Try to guess the filetype (may change later on during Neovim startup)
--     local ft = vim.filetype.match({ buf = event.buf })
--     if ft then
--       -- Add treesitter highlights and fallback to syntax
--       local lang = vim.treesitter.language.get_lang(ft)
--       if not (lang and pcall(vim.treesitter.start, event.buf, lang)) then
--         vim.bo[event.buf].syntax = ft
--       end
--
--       -- Trigger early redraw
--       vim.cmd([[redraw]])
--     end
--   end,
-- })

--- Load plugins
require('plugins')
