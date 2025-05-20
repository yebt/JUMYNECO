--- Lotus init ----------------------------

-- Allow experimental loading
vim.loader.enable()

-- Set leaders
vim.g.mapleader = vim.keycode('<space>')
vim.g.maplocal = vim.keycode('<space>')

require('configs.options')
