--- Load lspconfigs
local mlsp = require("modules.lsp")
mlsp.setup()
mlsp.words.setup({ enabled = true })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    --- Dependencies from the element
    if not client then
      return
    end
    if client.supports_method('textDocument/documentHighlight') then
      -- Create a keymap for vim.lsp.buf.implementation
      vim.keymap.set('n', ']]', function() mlsp.words.jump(vim.v.count1, true) end, {silent =true, desc="Next lsp highliht element"})
      vim.keymap.set('n', '[[', function() mlsp.words.jump(-vim.v.count1, true) end, {silent =true, desc="Prev lsp highliht element"})
    end

    -- vim.bo[args.buf].formatexpr = nil
    -- vim.bo[args.buf].omnifunc = nil
    -- vim.keymap.del('n', 'K', { buffer = args.buf })
  end,
})
