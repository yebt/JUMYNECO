--- Load lspconfigs
local kmp = vim.keymap
local mlsp = require('modules.lsp')

mlsp.setup()
mlsp.words.setup({ enabled = true })

--------
--- Border for signature help
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  -- Use a sharp border with `FloatBorder` highlights
  border = 'rounded',
})

--- Signs
local signs = { Error = '󰅚 ', Warn = '󰀪 ', Hint = '󰌶 ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
  local clientn = vim.lsp.get_client_by_id(ctx.client_id)
  local lvl = ({ 'ERROR', 'WARN', 'INFO', 'DEBUG' })[result.type]
  vim.notify(result.message, lvl, {
    title = 'LSP | ' .. clientn or clientn.name,
    timeout = 10000,
    keep = function()
      return lvl == 'ERROR' or lvl == 'WARN'
    end,
  })
end
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
-- vim.o.updatetime = 250
-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
--   group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
--   callback = function ()
--     vim.diagnostic.open_float(nil, {focus=false})
--   end
-- })
-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
--   group = vim.api.nvim_create_augroup("float_diagnostic_cursor", { clear = true }),
--   callback = function ()
--     vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})
--   end
-- })
-- local k

-- function PrintDiagnostics(opts, bufnr, line_nr, client_id)
--   bufnr = bufnr or 0
--   line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
--   opts = opts or {['lnum'] = line_nr}
--
--   local line_diagnostics = vim.diagnostic.get(bufnr, opts)
--   if vim.tbl_isempty(line_diagnostics) then return end
--
--   local diagnostic_message = ""
--   for i, diagnostic in ipairs(line_diagnostics) do
--     diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
--     print(diagnostic_message)
--     if i ~= #line_diagnostics then
--       diagnostic_message = diagnostic_message .. "\n"
--     end
--   end
--   vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
-- end
--
-- vim.api.nvim_create_autocmd("CursorHold", {
--   group = vim.api.nvim_create_augroup("print_diagnostics", { clear = true }),
--   callback = PrintDiagnostics
-- })
--------

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- Create a keymap for vim.lsp.buf.implementation
    kmp.set('n', ']]', function()
      mlsp.words.jump(vim.v.count1, true)
    end, { silent = true, desc = 'Next lsp highliht element' })
    kmp.set('n', '[[', function()
      mlsp.words.jump(-vim.v.count1, true)
    end, { silent = true, desc = 'Prev lsp highliht element' })

    local bufnr = args.buf
    -- local opts = { buffer = bufnr, noremap = true, silent = true }
    kmp.set(
      'n',
      'gD',
      vim.lsp.buf.declaration,
      { buffer = bufnr, noremap = true, silent = true, desc = 'LSP go to Declaration' }
    )
    kmp.set(
      'n',
      'gd',
      vim.lsp.buf.definition,
      { buffer = bufnr, noremap = true, silent = true, desc = 'LSP go to Definition' }
    )
    kmp.set(
      'n',
      '<leader>D',
      vim.lsp.buf.type_definition,
      { buffer = bufnr, noremap = true, silent = true, desc = 'LSP go to type definition' }
    )
    kmp.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, noremap = true, silent = true, desc = 'LSP Hover' })
    kmp.set(
      'n',
      'gi',
      vim.lsp.buf.implementation,
      { buffer = bufnr, noremap = true, silent = true, desc = 'LSP go to implementation' }
    )
    kmp.set(
      'n',
      '<C-k>',
      vim.lsp.buf.signature_help,
      { buffer = bufnr, noremap = true, silent = true, desc = 'LSP signature help' }
    )
    kmp.set(
      'n',
      '<leader>lwa',
      vim.lsp.buf.add_workspace_folder,
      { buffer = bufnr, noremap = true, silent = true, desc = 'LSP add workspace folder' }
    )
    kmp.set(
      'n',
      '<leader>lwr',
      vim.lsp.buf.remove_workspace_folder,
      { buffer = bufnr, noremap = true, silent = true, desc = 'LSP remove workspace folder' }
    )
    kmp.set('n', '<leader>lwl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { buffer = bufnr, noremap = true, silent = true, desc = 'LSP list work space' })
    kmp.set(
      'n',
      '<leader>rn',
      vim.lsp.buf.rename,
      { buffer = bufnr, noremap = true, silent = true, desc = 'LSP rename' }
    )
    kmp.set(
      'n',
      'gr',
      vim.lsp.buf.references,
      { buffer = bufnr, noremap = true, silent = true, desc = 'LSP references' }
    )
    kmp.set(
      'n',
      '<leader>e',
      vim.diagnostic.open_float,
      { buffer = bufnr, noremap = true, silent = true, desc = 'LSP diagnostic open float' }
    )
    kmp.set(
      'n',
      '[d',
      vim.diagnostic.goto_prev,
      { buffer = bufnr, noremap = true, silent = true, desc = 'LSP diagnostic prev' }
    )
    kmp.set(
      'n',
      ']d',
      vim.diagnostic.goto_next,
      { buffer = bufnr, noremap = true, silent = true, desc = 'LSP diagnostic next' }
    )
    kmp.set(
      'n',
      '<leader>lq',
      vim.diagnostic.setloclist,
      { buffer = bufnr, noremap = true, silent = true, desc = 'LSP diagnostic set loc list' }
    )

    -- vim.api.nvim_create_autocmd("CursorHold", {
    --   buffer = bufnr,
    --   callback = function()
    --     local optch = {
    --       focusable = false,
    --       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    --       border = 'rounded',
    --       source = 'always',
    --       prefix = ' ',
    --       scope = 'cursor',
    --     }
    --     vim.diagnostic.open_float(nil, optch)
    --   end
    -- })
    --

    -- local function goto_definition(split_cmd)
    --   local util = vim.lsp.util
    --   local log = require('vim.lsp.log')
    --   local api = vim.api
    --
    --   -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
    --   local handler = function(_, result, ctx)
    --     if result == nil or vim.tbl_isempty(result) then
    --       local _ = log.info() and log.info(ctx.method, 'No location found')
    --       return nil
    --     end
    --
    --     if split_cmd then
    --       vim.cmd(split_cmd)
    --     end
    --
    --     if vim.islist(result) then
    --       util.jump_to_location(result[1])
    --
    --       if #result > 1 then
    --         -- util.set_qflist(util.locations_to_items(result))
    --         vim.fn.setqflist(util.locations_to_items(result))
    --         api.nvim_command('copen')
    --         api.nvim_command('wincmd p')
    --       end
    --     else
    --       util.jump_to_location(result)
    --     end
    --   end
    --
    --   return handler
    -- end
    --
    -- vim.lsp.handlers['textDocument/definition'] = goto_definition('split')

    --- Dependencies from the cli
    if not client then
      return
    end
    -- if client.supports_method('textDocument/documentHighlight') then
    -- end

    -- vim.bo[args.buf].formatexpr = nil
    -- vim.bo[args.buf].omnifunc = nil
    -- kmp.del('n', 'K', { buffer = args.buf })
  end,
})
