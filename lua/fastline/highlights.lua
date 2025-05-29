local M = {}

function M.setup()
  vim.cmd("highlight FastlineLSP guifg=#98c379 guibg=NONE gui=bold")
  vim.cmd("highlight FastlineStartup guifg=#61afef guibg=NONE gui=bold")
  vim.cmd("highlight FastlineMode guifg=#e5c07b guibg=NONE gui=bold")
  vim.cmd("highlight FastlineFilename guifg=#abb2bf guibg=NONE")
  vim.cmd("highlight FastlineGit guifg=#ff6c6b guibg=NONE gui=bold")
  vim.cmd("highlight FastlineSeparator guifg=#5c6370 guibg=NONE")
end

return M

