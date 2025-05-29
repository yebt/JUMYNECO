local M = {}

function M.setup(opts)
  require("modeline.config").setup({
    sections = {
      left = { "lsp" },
      right = { "startup" },
      -- puedes agregar "git", "filename", etc.
    },
  })
  require("modeline.highlights").setup()
  vim.o.statusline = "%!v:lua.require'modeline.core'.render()"
end

return M
