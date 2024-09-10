---------------------------------------------
--- Autocmds
---------------------------------------------

---
local au = vim.api.nvim_create_autocmd
--- This file is automatically loaded by lazyvim.config.init.
local function augroup(name)
  return vim.api.nvim_create_augroup('_kernel_' .. name, { clear = true })
end

-------------------------------------------
--- auto no h in normal mode
-- vim.on_key(function(char)
--   if vim.fn.mode() == 'n' then
--     local new_hlsearch = vim.tbl_contains({ '<CR>', 'n', 'N', '*', '#', '?', '/' }, vim.fn.keytrans(char))
--     if vim.opt.hlsearch:get() ~= new_hlsearch then
--       vim.opt.hlsearch = new_hlsearch
--     end
--   end
-- end, vim.api.nvim_create_namespace('auto_hlsearch'))

-------------------------------------------
-- Check if we need to reload the file when it changed
au({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime'),
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd('checktime')
    end
  end,
})

-- Highlight on yank
au('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank({
      timeout = 100,
    })
  end,
})

-- resize splits if window got resized
au({ 'VimResized' }, {
  group = augroup('resize_splits'),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- go to last loc when opening a buffer
au('BufReadPost', {
  group = augroup('last_loc'),
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Automake the views
local view_group = augroup('_auto_view')
-- Make view
au({ 'BufWinLeave', 'BufWritePost', 'WinLeave' }, {
  desc = 'Save view with mkview for real files',
  group = view_group,
  callback = function(event)
    if vim.b[event.buf].view_activated then
      vim.cmd.mkview({ mods = { emsg_silent = true } })
    end
  end,
})

-- Load the view
au('BufWinEnter', {
  desc = 'Try to load file view if available and enable view saving for real files',
  group = view_group,
  callback = function(event)
    if not vim.b[event.buf].view_activated then
      local filetype = vim.api.nvim_get_option_value('filetype', { buf = event.buf })
      local buftype = vim.api.nvim_get_option_value('buftype', { buf = event.buf })
      local ignore_filetypes = { 'gitcommit', 'gitrebase', 'svg', 'hgcommit' }
      if buftype == '' and filetype and filetype ~= '' and not vim.tbl_contains(ignore_filetypes, filetype) then
        vim.b[event.buf].view_activated = true
        vim.cmd.loadview({ mods = { emsg_silent = true } })
      end
    end
  end,
})

--- Try early redraw
-- au('BufReadPost', {
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

-- close some filetypes with <q>
au('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'PlenaryTestPopup',
    'grug-far',
    'help',
    'lspinfo',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
    'dbout',
    'gitsigns.blame',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', {
      buffer = event.buf,
      silent = true,
      desc = 'Quit buffer',
    })
  end,
})

-- wrap and check for spell in text filetypes
au('FileType', {
  group = augroup('wrap_spell'),
  pattern = { 'text', 'plaintex', 'typst', 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.listchars.eol = '¶'
    --vim.opt_local.colorcolumn = '100'
    vim.opt_local.conceallevel = 2
  end,
})

-- Better conceal level for json files
au({ 'FileType' }, {
  group = augroup('json_conceal'),
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Make a clean view of the terminal
local c = augroup('terming')
au({ 'TermOpen' }, {
  group = c,
  callback = function()
    vim.opt_local.conceallevel = 0
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
    vim.cmd('startinsert')
  end,
})
--- Stat insert when focus in the terminal
au({ 'BufEnter', 'WinEnter' }, {
  pattern = { 'term://*' },
  group = c,
  command = [[startinsert]],
})
--- Leave insert when unfocus the terminal
au({ 'BufLeave' }, {
  pattern = { 'term://*' },
  group = c,
  command = [[stopinsert]],
})
