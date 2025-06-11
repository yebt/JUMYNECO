--- General capabilities
vim.lsp.config('*', {
  capabilities = {
    textDocument = {

      -- Semantik tokens
      semanticTokens = {
        multilineTokenSupport = true,
      },

      -- Completion capabilities
      completion = {
        completionItem = {
          snippetSupport = true,
        },
      },

      -- Folds
      -- foldingRange = {
      --   dynamicRegistration = false,
      --   lineFoldingOnly = true
      -- }
    },

    workspace = {
      -- Detect file changes
      fileOperations = {
        didRename = true,
        willRename = true,
      },
      --- Discover new files
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
  -- root_markers = { '.git' },
})

---
-- vim.lsp.set_log_level 'trace'
--

-- OFF the log of lsp
-- vim.lsp.log.set_level(vim.log.levels.OFF)
local icons = {
  Error = 'E',
  Warn = 'W',
  Info = 'I',
  Hint = 'H',
}

--- Diagnostic configs
vim.diagnostic.config({
  virtual_text = {
    current_line = true,
    spacing = 4,
    source = 'if_many',
    -- prefix = "●",
  },
  -- virtual_lines ={
  --   current_line = true,
  -- },
  underline = true,
  update_in_insert = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.Error,
      [vim.diagnostic.severity.WARN] = icons.Warn,
      [vim.diagnostic.severity.HINT] = icons.Hint,
      [vim.diagnostic.severity.INFO] = icons.Info,
    },
  },
})

-- Formatter selector

local function execute_client_formatter(client)
  if client then
    vim.lsp.buf.format({
      bufnr = bufnr,
      filter = function(c)
        return c.id == client.id
      end,
    })
    vim.notify('Formatted with: ' .. client.name)
  end
end

local function format_with_client()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr, method = 'textDocument/formatting' })

  if #clients == 0 then
    vim.notify('No LSP clients support formatting', vim.log.levels.WARN)
    return
  end

  if #clients == 1 then
    execute_client_formatter(clients[0])
    return
  end

  vim.ui.select(clients, {
    prompt = 'Select LSP client for formatting:',
    format_item = function(client)
      return client.name
    end,
  }, execute_client_formatter)
end


vim.api.nvim_create_autocmd('LspAttach', {
  -- callback = function(args)
  callback = function()
    vim.keymap.set('n', '<M-F>', format_with_client, { desc = "LSP Formatter" })
    vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, { desc = "LSP Format Select" })
    vim.keymap.set('n', '<leader>lrn', vim.lsp.buf.rename, { desc = "LSP Rename" })
    vim.keymap.set('n', '<leader>lih', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = "LSP Toggle Inline Hint" })

  end,
})

-- Crea un comando de usuario llamado :LspCommands
vim.api.nvim_create_user_command('LspCommands', function()
  -- Obtiene los clientes para el buffer actual
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    vim.notify("No hay servidores LSP activos para este buffer.", vim.log.levels.WARN)
    return
  end

  vim.notify("Comandos disponibles de los servidores LSP:", vim.log.levels.INFO, { title = "LSP" })

  -- Itera sobre cada cliente activo
  for _, client in ipairs(clients) do
    local commands = client.server_capabilities.executeCommandProvider and client.server_capabilities.executeCommandProvider.commands or nil

    if commands and #commands > 0 then
      -- Usa vim.notify para mostrar una notificación bonita y no invasiva
      vim.notify(
        "Servidor: " .. client.name .. "\n" .. table.concat(commands, "\n"),
        vim.log.levels.INFO,
        { title = "Comandos de " .. client.name }
      )
    else
      vim.notify(
        "El servidor '" .. client.name .. "' no reporta comandos.",
        vim.log.levels.INFO,
        { title = "Comandos de " .. client.name }
      )
    end
  end
end, {
desc = "Muestra los comandos disponibles de los servidores LSP activos"
})

-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('my.lsp', {}),
--   callback = function(args)
--     local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--     if client:supports_method('textDocument/implementation') then
--       -- Create a keymap for vim.lsp.buf.implementation ...
--     end
--     -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
--     if client:supports_method('textDocument/completion') then
--       -- Optional: trigger autocompletion on EVERY keypress. May be slow!
--       -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
--       -- client.server_capabilities.completionProvider.triggerCharacters = chars
--       vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
--     end
--     -- Auto-format ("lint") on save.
--     -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
--     if not client:supports_method('textDocument/willSaveWaitUntil')
--         and client:supports_method('textDocument/formatting') then
--       vim.api.nvim_create_autocmd('BufWritePre', {
--         group = vim.api.nvim_create_augroup('my.lsp', {clear=false}),
--         buffer = args.buf,
--         callback = function()
--           vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
--         end,
--       })
--     end
--   end,
-- })
--

-- local api = vim.api
-- local au = api.nvim_create_autocmd
-- local g = api.nvim_create_augroup('glepnir.completion', { clear = true })


vim.o.cot = 'menu,menuone,noinsert,fuzzy,popup'
vim.o.cia = 'kind,abbr,menu'
-- au('LspAttach', {
--   group = g,
--   callback = function(args)
--     local lsp = vim.lsp
--     local completion = lsp.completion
--     local ms = lsp.protocol.Methods
--
--     local bufnr = args.buf
--     local client = lsp.get_client_by_id(args.data.client_id)
--     if not client or not client:supports_method(ms.textDocument_completion) then
--       return
--     end
--
--     if not vim.env.DEBUG_COMPLETION then
--       local chars = client.server_capabilities.completionProvider.triggerCharacters
--       if chars then
--         for i = string.byte('a'), string.byte('z') do
--           if not vim.list_contains(chars, string.char(i)) then
--             table.insert(chars, string.char(i))
--           end
--         end
--
--         for i = string.byte('A'), string.byte('Z') do
--           if not vim.list_contains(chars, string.char(i)) then
--             table.insert(chars, string.char(i))
--           end
--         end
--       end
--     end
--
--     completion.enable(true, client.id, bufnr, {
--       -- autotrigger = not vim.env.DEBUG_COMPLETION and true or { any = true },
--       autotrigger = true,
--       convert = function(item)
--         local kind = lsp.protocol.CompletionItemKind[item.kind] or 'u'
--         return {
--           abbr = item.label:gsub('%b()', ''),
--           kind = kind:sub(1, 1):lower(),
--           menu = '',
--         }
--       end,
--     })
--
--     if
--       #api.nvim_get_autocmds({
--         buffer = bufnr,
--         event = { 'CompleteChanged' },
--         group = g,
--       }) == 0
--     then
--       au('CompleteChanged', {
--         buffer = bufnr,
--         group = g,
--         callback = function()
--           local info = vim.fn.complete_info({ 'selected' })
--           if info.preview_bufnr and vim.bo[info.preview_bufnr].filetype == '' then
--             vim.bo[info.preview_bufnr].filetype = 'markdown'
--             vim.wo[info.preview_winid].conceallevel = 2
--             vim.wo[info.preview_winid].concealcursor = 'niv'
--           end
--         end,
--       })
--
--       au('CompleteDone', {
--         buffer = bufnr,
--         group = g,
--         callback = function()
--           local item =
--             vim.tbl_get(vim.v.completed_item, 'user_data', 'nvim', 'lsp', 'completion_item')
--           if not item then
--             return
--           end
--
--           if
--             item.kind == 3
--             and item.insertTextFormat == lsp.protocol.InsertTextFormat.Snippet
--             and (item.textEdit ~= nil or item.insertText ~= nil)
--           then
--             vim.schedule(function()
--               if api.nvim_get_mode().mode == 's' then
--                 lsp.buf.signature_help()
--               end
--             end)
--           end
--         end,
--         desc = 'Auto show signature help when compeltion done',
--       })
--     end
--   end,
-- })
