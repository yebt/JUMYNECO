local M = {}

local startup_time = nil

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    startup_time = vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time or vim.g.vim_start_time or vim.fn.reltime()))
  end,
})

function M.get()
  if startup_time then
    return string.format("%%#ModelineStartup#Startup: %.2fms", startup_time * 1000)
  else
    return "%#ModelineStartup#Startup: n/a"
  end
end

return M

