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
