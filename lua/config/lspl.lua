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
    vim.keymap.set('n', '<leader>lrn', vim.lsp.buf.rename, { desc = "LSP Rename" })
    vim.keymap.set('n', '<leader>lih', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = "LSP Toggle Inline Hint" })

  end,
})
