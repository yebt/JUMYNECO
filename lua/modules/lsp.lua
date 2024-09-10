vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    -- vim.bo[args.buf].formatexpr = nil
    -- vim.bo[args.buf].omnifunc = nil
    -- vim.keymap.del('n', 'K', { buffer = args.buf })
  end,
})
