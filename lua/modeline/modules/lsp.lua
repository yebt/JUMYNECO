local M = {}

function M.get()
  -- DEPRECATED
  -- local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  local clients =  vim.lsp.get_clients({bufnr = 0})
  if #clients == 0 then
    -- return "%#ModelineLSP#LSP: none"
    return ""
  end

  local names = {}
  for _, client in pairs(clients) do
    table.insert(names, client.name)
  end

  return "%#ModelineLSP#LSP: " .. table.concat(names, ", ")
end

return M

