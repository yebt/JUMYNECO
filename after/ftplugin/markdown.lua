-- vim.opt_local.conceallevel = 0
vim.opt_local.formatexpr = ''
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.textwidth = 80
vim.opt_local.colorcolumn = '80'

--
-- Function to insert empty brackets up and below
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

-- function toggleMark()
-- 	local actual_line = vim.fn.getline(vim.fn.line("."))
-- 	local marks = {" ","x","-"}
-- 	vim.fn.match(prev_line, "^[ \\t]*-")
-- end

-- Maps

vim.keymap.set('n', 'o', SetupEmptyBrackets, { noremap = true, silent = false })

vim.keymap.set('n', '<leader>tt', ToggleCheckbox, { desc = 'toggle todo mark' })

function InsertLink()

  vim.ui.select(
    {'clipboard', 'empty'},
    {
      prompt = 'Select link type: ',
    },
    function(choice)
      if choice == 'clipboard' then
        vim.cmd('normal i[mi]("+pa)`id`i')
        vim.cmd('startinsert')
      elseif choice == 'empty' then
        vim.cmd('normal i[]()')
        vim.cmd('startinsert')
      end
    end
  )

end
vim.keymap.set('i', '<M-i>', InsertLink, { desc = 'Inser link', silent = true })
-- vim.keymap.set('i', '<M-i>', '[<C-o>mi](<C-o>"+p)<ESC>`id`ia', { desc = 'Inser link' })
-- vim.keymap.set('i', '<M-I>', '![<C-o>mi](<C-o>"+p)<ESC>`id`ia', { desc = 'Inser link' })

