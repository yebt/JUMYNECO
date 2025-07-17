vim.opt_local.textwidth = 80
vim.opt_local.colorcolumn = '80'

--- ==========================================================================================
---
-- add todo woth O
function SetupEmptyBrackets()
  local prev_line = vim.fn.getline(vim.fn.line('.'))
  --return vim.fn.match(prev_line, "^[ \\t]*\\[.\\]") == 0
  local mapk = 'o'
  if vim.fn.match(prev_line, '^[ \\t]*- \\[.\\]') == 0 then
    -- TODOtype
    mapk = mapk .. '- [ ] '
  elseif vim.fn.match(prev_line, '^[ \\t]*-') == 0 then
    -- bullet type
    mapk = mapk .. '- '
  elseif vim.fn.match(prev_line, '^[ \\t]*\\*') == 0 then
    mapk = mapk .. '* '
  end
  vim.api.nvim_feedkeys(mapk, 'n', true)
end

-- Toggle checkbox
function ToggleCheckbox()
  local line_number = vim.fn.line('.')
  local line_content = vim.fn.getline(line_number)

  if vim.fn.match(line_content, '^[ \\t]*- \\[.\\]') == 0 then
    -- if is check
    if vim.fn.match(line_content, '^[ \\t]*- \\[[xX]\\]') == 0 then
      local new_content = line_content:gsub('- %[[xX]%]', '- [ ]')
      vim.fn.setline(line_number, new_content)
    elseif vim.fn.match(line_content, '^[ \\t]*- \\[ \\]') == 0 then
      local new_content = line_content:gsub('- %[ %]', '- [x]')
      vim.fn.setline(line_number, new_content)
    end
  end
end

function InsertLink()
  vim.ui.select({ 'clipboard', 'empty' }, {
    prompt = 'Select link type: ',
  }, function(choice)
    if choice == 'clipboard' then
      vim.cmd('normal i[mi]("+pa)`id`i')
      vim.cmd('startinsert')
    elseif choice == 'empty' then
      vim.cmd('normal i[]()')
      vim.cmd('startinsert')
    end
  end)
end

local function create_code_block()
  local line = vim.fn.getline('.')
  -- local language = vim.fn.input('Enter language: ')
  vim.ui.input({
    prompt = 'Enter language: ',
    default = 'txt',
  }, function(language)
    if language ~= nil then
      local lines = {
        '```' .. language,
        '',
        '```',
      }
      vim.api.nvim_put(lines, 'l', true, false)
      -- Move the cursor to the middle of the code block
      local row = vim.api.nvim_win_get_cursor(0)[1] -- Get current row
      vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
    end
  end)
end

--- ==========================================================================================


vim.keymap.set('n', 'o', SetupEmptyBrackets, { noremap = true, silent = false })

vim.keymap.set('n', '<leader>tt', ToggleCheckbox, { desc = 'toggle todo mark' })

vim.keymap.set('i', '<M-b>', create_code_block, { desc = 'Insert Code Block', silent = true })

vim.keymap.set('i', '<M-l>', InsertLink, { desc = 'Inser link', silent = true })

vim.keymap.set('i', '<C-b>', '****h', { noremap = true, silent = true })
vim.keymap.set('v', '<C-b>', '"zc****hh"zp', { noremap = true, silent = true })

vim.keymap.set('i', '<M-i>', '__i', { noremap = true, silent = true })
vim.keymap.set({ 'v' }, '<M-i>', '"zc__h"zp', { noremap = true, silent = true })

