---------------------------------------------
--- Remaps and Key Mappings
---------------------------------------------

local fns = require('utils.maps')
local mp = vim.keymap.set

--- Usage
mp('n', '0', fns.homeVsKey, { silent = true, expr = true, desc = "Go to start of line like 'Home' in vscode" })

--- Break the undo for no remove all word
mp('i', ',', ',<c-g>u')
mp('i', '.', '.<c-g>u')
mp('i', ';', ';<c-g>u')

--- Save
mp('n', '<leader>q', '<cmd>q<CR>', { silent = true, desc = 'Quit of nvim' })
--- Quit
mp('n', '<leader>w', '<cmd>w<CR>', { silent = true, desc = 'Save buffer' })
--- Stop with C-c like ESC key
mp({ 'x', 'i', 'n' }, '<C-c>', '<ESC>', { silent = true, desc = 'Stop like C-c like ESC' })
--- Clear the search with esc
mp({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { silent = true, desc = 'Clear searcher with esc' })
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

--- Move the lines
-- mp('v', 'J', ":m '>+1<CR>gv=gv", { silent = true, desc = 'Move selection up' })
-- mp('v', 'K', ":m '<-2<CR>gv=gv", { silent = true, desc = 'Move selection down' })
--- Move lines Lazynvim
-- mp("n", "<M-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
-- mp("n", "<M-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
-- mp('i', '<M-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
-- mp('i', '<M-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
mp('v', '<M-j>', ":m '>+1<cr>gv=gv", { desc = 'Move Down' })
mp('v', '<M-k>', ":m '<-2<cr>gv=gv", { desc = 'Move Up' })

--- Basic surround
mp('x', '<C-s>', fns.surround, { silent = true, expr = true, desc = 'Add surround to selection' })

--- Replace cursor word
mp(
  'n',
  '<leader>r',
  '<cmd>%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>',
  { desc = 'Remplace cursor word, in all document' }
)

--- Manage Splits
mp('n', '<M-Bar>', '<cmd>vsplit<cr>', { silent = true, desc = 'Vertical split' })
mp('n', '<M-->', '<cmd>split<cr>', { silent = true, desc = 'Horizontal split' })

--- NETRW
mp('n', '\\', fns.toggleNetrw, { silent = true, desc = 'Toggle netrw' })

--- Move beetween splits
mp('n', '<M-h>', '<C-w>h', { silent = true, desc = 'Move to left split' })
mp('n', '<M-l>', '<C-w>l', { silent = true, desc = 'Move to right split' })
mp('n', '<M-k>', '<C-w>k', { silent = true, desc = 'Move to up split' })
mp('n', '<M-j>', '<C-w>j', { silent = true, desc = 'Move to down split' })

--- Resize windows
mp('n', '<C-Up>', '<cmd>resize +2<cr>', { silent = true, desc = 'Increase Window Height' })
mp('n', '<C-Down>', '<cmd>resize -2<cr>', { silent = true, desc = 'Decrease Window Height' })
mp('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { silent = true, desc = 'Increase Window Width' })
mp('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { silent = true, desc = 'Decrease Window Width' })

--- Move trough buffers
mp('n', '<M-d>', '<cmd>bnext<cr>', { silent = true, desc = 'Go to next buffer' })
mp('n', '<M-a>', '<cmd>bprevious<cr>', { silent = true, desc = 'Go to prev buffer' })
mp('n', '<M-s>', '<cmd>e #<cr>', { silent = true, desc = 'Go to altername buffer' })

--- Comments
mp('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
mp('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

--- Remove buffer
mp('n', '<M-c>', fns.brem2, { silent = true, desc = 'Delete buffer' })
mp('n', '<M-C>', '<cr>bd<cr>', { silent = true, desc = 'Delete buffer' })

--- Toggler Wrap
mp('n', '<M-z>w', '<cmd>set wrap!<CR>', { silent = true, desc = 'Toggle wrap' })
mp('n', '<M-z>m', fns.toggleMaximize, { silent = true, desc = 'Toggle maximize windows' })

--- Terminal
--- Escape in the terminal
mp('t', '<esc><esc>', '<C-\\><C-n>', { silent = true, desc = 'Exit terminal insert mode' })
-- mp("t", "<c-_>", "<cmd>close<cr>", { desc = "Close the terminal" })
