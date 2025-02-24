-- vim.api.nvim_exec_autocmds('ColorScheme', {
--   pattern = '*',
--   callback = function()
--     vim.api.nvim_set_hl_ns_fast(0)
--     vim.api.nvim_set_hl(0, 'MatchParen', { bold = true, underline = true, reverse = true })
--   end,
-- })
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  group = vim.api.nvim_create_augroup('_personal_colors', {}),
  callback = function()
    -- vim.api.nvim_set_hl_ns_fast(0)
    -- vim.api.nvim_set_hl(0, 'MatchParen', { bold = true, underline = true, reverse = true })
    -- ---
    -- local hi = function(name, opts)
    --   opts.default = true
    --   vim.api.nvim_set_hl(0, name, opts)
    -- end
    --
    -- hi('MiniIconsAzure', { link = 'Function' })
    -- hi('MiniIconsBlue', { link = 'DiagnosticInfo' })
    -- hi('MiniIconsCyan', { link = 'DiagnosticHint' })
    -- hi('MiniIconsGreen', { link = 'DiagnosticOk' })
    -- hi('MiniIconsGrey', {})
    -- hi('MiniIconsOrange', { link = 'DiagnosticWarn' })
    -- hi('MiniIconsPurple', { link = 'Constant' })
    -- hi('MiniIconsRed', { link = 'DiagnosticError' })
    -- hi('MiniIconsYellow', { link = 'DiagnosticWarn' })
  end,
})
