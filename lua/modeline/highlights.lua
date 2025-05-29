local M = {}

function M.setup()
  vim.cmd("highlight ModelineLSP guifg=#98c379 guibg=NONE gui=bold")
  vim.cmd("highlight ModelineStartup guifg=#61afef guibg=NONE gui=bold")
  vim.cmd("highlight ModelineSeparator guifg=#5c6370 guibg=NONE")
end

return M

