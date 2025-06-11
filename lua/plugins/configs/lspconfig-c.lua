return function ()

  local lspconfigsdir = vim.fn.stdpath 'config' .. "/lua/config/lspconfigs"

  local function ends_with(str, ending)
    return ending == "" or str:sub(-#ending) == ending
  end

  -- Iterate through files in the directory
  for _, file in ipairs(vim.fn.readdir(lspconfigsdir)) do

    if ends_with(file, '.lua') then
      local mod = file:gsub('%.lua$', '')   -- Remove .lua extension
      local server_name = mod
      local server_settings = require('config.lspconfigs.'..mod)
      vim.lsp.enable(server_name)
      vim.lsp.config(server_name,server_settings)
    end
  end
end
