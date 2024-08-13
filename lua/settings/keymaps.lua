--- ----------------------------------------
--- This are the maps
--- ----------------------------------------
-- Add keymap to resize a windows wit the winwidth and ctrl + w

local fns = require('utils.maps')
local mp = vim.keymap.set

--- Usage
mp('n', '0', fns.homeVsKey, { silent = true, expr = true, desc = "Go to start of line like 'Home' in vscode" })

--- Save
mp('n', '<leader>q', ':q<CR>', { silent = true, desc = 'Quit of nvim' })
--- Quit
mp('n', '<leader>w', ':w<CR>', { silent = true, desc = 'Save buffer' })
--- Stop with C-c like ESC key
mp({ 'x', 'i', 'n' }, '<C-c>', '<ESC>', { silent = true, desc = 'Stop like C-c like ESC' })
--- Select all content of the buffer
mp('n', '<leader>a', 'ggVG', { silent = true, desc = 'select all content' })
--- Not use C-z
mp({ 'n' }, '<C-z>', '', {})

--- Yaks
mp({ 'x', 'v' }, '<leader>y', '"+y', { silent = true, desc = 'Copy the selection inside the system clipboard' })
mp(
  'n',
  '<leader>Y',
  '"+y$',
  { silent = true, desc = 'Copy from position until to end of the line inside the system clipboard' }
)
mp('n', '<leader>y', '"+y', { silent = true, desc = 'Start copy to system clipboard yank' })
-- mps('n', '<leader>yy', '"+yy', { silent = true, desc = 'Copy the lines' })

--- Paste
mp('x', '<leader>p', '"_dP', { silent = true, desc = 'Paste without losee content' })

--- Edit
mp('n', '[<space>', fns.blank_above, { silent = true, desc = 'Blank above' })
mp('n', ']<space>', fns.blank_below, { silent = true, desc = 'Blank below' })

--- Indentation
mp('x', '<', '<gv', { silent = true, desc = 'Decrease indentation of selection' })
mp('x', '>', '>gv', { silent = true, desc = 'Increase indentation of selection' })
mp('v', 'J', ":m '>+1<CR>gv=gv", { silent = true, desc = 'Move selection up' })
mp('v', 'K', ":m '<-2<CR>gv=gv", { silent = true, desc = 'Move selection down' })

--- Basic surround
mp('x', '<C-s>', fns.surround, { silent = true, expr = true, desc = 'Add surround to selection' })

-- Replace cursor word
mp(
  'n',
  '<leader>r',
  ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>',
  { desc = 'Remplace cursor word, in all document' }
)

--- Manage Splits
mp('n', '<M-Bar>', ':vsplit<cr>', { silent = true, desc = 'Vertical split' })
mp('n', '<M-->', ':split<cr>', { silent = true, desc = 'Horizontal split' })

--- NETRW
mp('n', '\\', fns.toggleNetrw, { silent = true, desc = 'Toggle netrw' })

-- Move beetween splits
mp('n', '<M-h>', '<C-w>h', { silent = true, desc = 'Move to left split' })
mp('n', '<M-l>', '<C-w>l', { silent = true, desc = 'Move to right split' })
mp('n', '<M-k>', '<C-w>k', { silent = true, desc = 'Move to up split' })
mp('n', '<M-j>', '<C-w>j', { silent = true, desc = 'Move to down split' })
-- Move trough buffers
mp('n', '<M-d>', ':bn<cr>', { silent = true, desc = 'Go to next buffer' })
mp('n', '<M-a>', ':bp<cr>', { silent = true, desc = 'Go to prev buffer' })
mp('n', '<M-s>', ':b#<cr>', { silent = true, desc = 'Go to altername buffer' })

-- Remove buffer
mp('n', '<M-c>', fns.brem, { silent = true, desc = 'Delete buffer' })

-- Escape in the terminal
mp('t', '<ESC>', '<C-\\><C-n>', { silent = true, desc = 'Exit terminal insert mode' })
