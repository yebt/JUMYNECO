local map = vim.keymap.set

-- map('n', '\\', ':Ex %:h<cr>')

--- Break the undo for no remove all word
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')
map('i', '<cr>', '<cr><c-g>u')

--- Quit
map('n', '<leader>q', '<cmd>q<CR>', { silent = true, desc = 'Quit of nvim' })
map('n', '<M-q>', '<cmd>qa<CR>', { silent = true, desc = 'Quit of all panels nvim' })
map({ 'n' }, '<M-Q>', '<cmd>qa!<CR>', { silent = true, desc = 'Quit of nvim forzed' })

--- Save
map('n', '<leader>w', '<cmd>w<CR>', { silent = true, desc = 'Save buffer' })
--- Stop with C-c like ESC key
map({ 'x', 'i', 'n' }, '<C-c>', '<ESC>', { silent = true, desc = 'Stop like C-c like ESC' })
--- Clear the search with esc
map({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { silent = true, desc = 'Clear searcher with esc' })
--- Select all content of the buffer
map('n', '<leader>a', 'ggVG', { silent = true, desc = 'select all content' })
--- Not use C-z
map({ 'n' }, '<C-z>', '', {})

--- Yaks
map({ 'x', 'v' }, '<leader>y', '"+y', { silent = true, desc = 'Copy the selection inside the system clipboard' })
map(
  'n',
  '<leader>Y',
  '"+y$',
  { silent = true, desc = 'Copy from position until to end of the line inside the system clipboard' }
)
map('n', '<leader>y', '"+y', { silent = true, desc = 'Start copy to system clipboard yank' })
-- mps('n', '<leader>yy', '"+yy', { silent = true, desc = 'Copy the lines' })

--- Paste
map('x', '<leader>p', '"_dP', { silent = true, desc = 'Paste without losee content' })

--- Indentation
map('x', '<', '<gv', { silent = true, desc = 'Decrease indentation of selection' })
map('x', '>', '>gv', { silent = true, desc = 'Increase indentation of selection' })

--- Move the lines
-- mp('v', 'J', ":m '>+1<CR>gv=gv", { silent = true, desc = 'Move selection up' })
-- mp('v', 'K', ":m '<-2<CR>gv=gv", { silent = true, desc = 'Move selection down' })
--- Move lines Lazynvim
-- mp("n", "<M-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
-- mp("n", "<M-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
-- mp('i', '<M-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
-- mp('i', '<M-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
map('v', '<M-j>', ":m '>+1<cr>gv=gv", { desc = 'Move Down' })
map('v', '<M-k>', ":m '<-2<cr>gv=gv", { desc = 'Move Up' })

--- Replace cursor word
map(
  'n',
  '<leader>rw',
  ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>',
  { desc = 'Remplace cursor word, in all document' }
)

--- Manage Splits
map('n', '<M-Bar>', '<cmd>vsplit<cr>', { silent = true, desc = 'Vertical split' })
map('n', '<M-->', '<cmd>split<cr>', { silent = true, desc = 'Horizontal split' })

--- Move beetween splits
map('n', '<M-h>', '<C-w>h', { silent = true, desc = 'Move to left split' })
map('n', '<M-l>', '<C-w>l', { silent = true, desc = 'Move to right split' })
map('n', '<M-k>', '<C-w>k', { silent = true, desc = 'Move to up split' })
map('n', '<M-j>', '<C-w>j', { silent = true, desc = 'Move to down split' })

--- Resize windows
map('n', '<C-Up>', '<cmd>resize +2<cr>', { silent = true, desc = 'Increase Window Height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { silent = true, desc = 'Decrease Window Height' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { silent = true, desc = 'Increase Window Width' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { silent = true, desc = 'Decrease Window Width' })

--- Move trough buffers
map('n', '<M-d>', '<cmd>bnext<cr>', { silent = true, desc = 'Go to next buffer' })
map('n', '<M-a>', '<cmd>bprevious<cr>', { silent = true, desc = 'Go to prev buffer' })
map('n', '<M-s>', '<cmd>e #<cr>', { silent = true, desc = 'Go to altername buffer' })

--- Comments
-- map('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
-- map('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

--- Toggler Wrap
map('n', '<M-z>w', '<cmd>set wrap!<CR>', { silent = true, desc = 'Toggle wrap' })

--- Terminal
--- Escape in the terminal
map('t', '<esc><esc>', '<C-\\><C-n>', { silent = true, desc = 'Exit terminal insert mode' })
