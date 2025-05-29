local M = {}

function colorize(name, opts)
  vim.api.nvim_set_hl(0, name,opts)
end

function M.setup()
  local colors = {
    green_pistachio = "#98c379",
    blue_argentinian = "#61afef",
    gray_paynes = "#5c6370",
  }

  local theme = {
    ["ModelineLSP"] = {fg = colors.green_pistachio, bold = true},
    ["ModelineStartup"] = {fg = colors.blue_argentinian, bold = true},
    ["ModelineSeparator"] = {fg = colors.gray_paynes},
  }
  for name, opts in pairs(theme) do
    colorize(name, opts)
  end
  -- vim.cmd("highlight ModelineLSP guifg=#98c379 guibg=NONE gui=bold")
  -- vim.cmd("highlight ModelineStartup guifg=#61afef guibg=NONE gui=bold")
  -- vim.cmd("highlight ModelineMode guifg=#e5c07b guibg=NONE gui=bold")
  -- vim.cmd("highlight ModelineFilename guifg=#abb2bf guibg=NONE")
  -- vim.cmd("highlight ModelineGit guifg=#ff6c6b guibg=NONE gui=bold")
  -- vim.cmd("highlight ModelineSeparator guifg=#5c6370 guibg=NONE")
end

return M

