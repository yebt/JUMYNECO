local M = {}

local function execute_client_formatter(client, msg_sufix)
  msg_sufix = msg_sufix or ''
  if client then
    vim.lsp.buf.format({
      bufnr = 0,
      filter = function(c)
        return c.id == client.id
      end,
    })
    vim.notify('Formatted with: ' .. client.name .. msg_sufix)
  end
end

local CACHE_PATH = vim.fn.stdpath('state') .. '/formatter_cache.json'

local function load_cache()
  local fd = io.open(CACHE_PATH, 'r')
  if not fd then return {} end
  local ok, tbl = pcall(vim.json.decode, fd:read('*a'))
  fd:close()
  return (ok and type(tbl) == 'table') and tbl or {}
end

local function save_cache(tbl)
  local ok, json = pcall(vim.json.encode, tbl)
  if not ok then return end
  local fd = io.open(CACHE_PATH, 'w')
  if not fd then return end
  fd:write(json)
  fd:close()
end


local function pick_and_save_client(clients)
  vim.ui.select(clients, {
    prompt = 'Select LSP client for formatting:',
    format_item = function(c) return c.name end,
  }, function(client)
    if not client then return end
    local cache = load_cache()
    cache[vim.bo.filetype] = client.name
    save_cache(cache)
    execute_client_formatter(client)
  end)
end

-- @DEPRECATED
-- M.format_with_client = function()
--   local bufnr = vim.api.nvim_get_current_buf()
--   local clients = vim.lsp.get_clients({ bufnr = bufnr, method = 'textDocument/formatting' })
--
--   if #clients == 0 then
--     vim.notify('No LSP clients support formatting', vim.log.levels.WARN)
--     return
--   end
--
--   if #clients == 1 then
--     execute_client_formatter(clients[1])
--     return
--   end
--
--   vim.ui.select(clients, {
--     prompt = 'Select LSP client for formatting:',
--     format_item = function(client)
--       return client.name
--     end,
--   }, execute_client_formatter)
-- end

M.format_with_client = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr, method = 'textDocument/formatting' })

  if #clients == 0 then
    vim.notify('No LSP clients support formatting', vim.log.levels.WARN)
    return
  end
  if #clients == 1 then
    -- también guarda para reusar luego
    local cache = load_cache()
    cache[vim.bo.filetype] = clients[1].name
    save_cache(cache)
    execute_client_formatter(clients[1])
    return
  end

  pick_and_save_client(clients)
end

M.format_with_client_last = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr, method = 'textDocument/formatting' })

  if #clients == 0 then
    vim.notify('No LSP clients support formatting', vim.log.levels.WARN)
    return
  end
  if #clients == 1 then
    execute_client_formatter(clients[1])
    return
  end

  local cache = load_cache()
  local wanted = cache[vim.bo.filetype]
  if wanted then
    for _, c in ipairs(clients) do
      if c.name == wanted then
        execute_client_formatter(c, ' FROM CAHCE')
        return
      end
    end
    -- cliente guardado no está activo; cae al selector
  end

  pick_and_save_client(clients)
end

return M
