-- OFF the log of lsp
vim.lsp.log.set_level(vim.log.levels.OFF)

--- Diagnostic configs
vim.diagnostic.config({
  virtual_text = { current_line = true },
  signs = {
    text = { '●', '●', '●', '●' },
  },
})
