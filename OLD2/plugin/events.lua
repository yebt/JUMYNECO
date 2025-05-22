--- Events to execute
local api = vim.api
local au = api.nvim_create_autocmd
local group = api.nvim_create_augroup('LotusGroup', {})

-- File
au({ "FocusGained", "TermClose", "TermLeave"}, {
  group = group,
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
  desc = "Check if is needed reload file when it changed"
})

--- highlight
au('TextYankPost', {
  group = group,
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 75 })
  end,
  desc = "Highlight the yanked text"
})

--- term
au('TermOpen', {
  group = group,
  command = 'setl stc= nonumber | startinsert!',
  desc = "Make the terminal usabe"
})

