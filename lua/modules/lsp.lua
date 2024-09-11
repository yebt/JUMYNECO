local vapi, vmap, vv, vlsp = vim.api, vim.keymap, vim.v, vim.lsp

--- Load words
local mlsp = require('modules.lspUtils')
mlsp.setup()

local lspwords = mlsp.words
lspwords.setup()

--- Has

function Mhas(buffer, method)
  if type(method) == 'table' then
    for _, m in ipairs(method) do
      if Mhas(buffer, m) then
        return true
      end
    end
    return false
  end
  method = method:find('/') and method or 'textDocument/' .. method
  local clients = mlsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

--
vapi.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    -- print(vim.inspect(args))

    -- vmap.set({})
    -- M._keys =  {
    --   { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
    --   { "gd", vlsp.buf.definition, desc = "Goto Definition", has = "definition" },
    --   { "gr", vlsp.buf.references, desc = "References", nowait = true },
    --   { "gI", vlsp.buf.implementation, desc = "Goto Implementation" },
    --   { "gy", vlsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
    --   { "gD", vlsp.buf.declaration, desc = "Goto Declaration" },
    --   { "K", vlsp.buf.hover, desc = "Hover" },
    --   { "gK", vlsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    --   { "<c-k>", vlsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
    --   { "<leader>ca", vlsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
    --   { "<leader>cc", vlsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
    --   { "<leader>cC", vlsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
    --   { "<leader>cR", Lazyvlsp.rename_file, desc = "Rename File", mode ={"n"}, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
    --   { "<leader>cr", vlsp.buf.rename, desc = "Rename", has = "rename" },
    --   { "<leader>cA", Lazyvlsp.action.source, desc = "Source Action", has = "codeAction" },
    --   { "]]", function() Lazyvlsp.words.jump(vim.v.count1) end, has = "documentHighlight",
    --     desc = "Next Reference", cond = function() return Lazyvlsp.words.enabled end },
    --   { "[[", function() Lazyvlsp.words.jump(-vim.v.count1) end, has = "documentHighlight",
    --     desc = "Prev Reference", cond = function() return Lazyvlsp.words.enabled end },
    --   { "<a-n>", function() Lazyvlsp.words.jump(vim.v.count1, true) end, has = "documentHighlight",
    --     desc = "Next Reference", cond = function() return Lazyvlsp.words.enabled end },
    --   { "<a-p>", function() Lazyvlsp.words.jump(-vim.v.count1, true) end, has = "documentHighlight",
    --     desc = "Prev Reference", cond = function() return Lazyvlsp.words.enabled end },
    -- }
    -- vim.bo[args.buf].formatexpr = nil
    -- vim.bo[args.buf].omnifunc = nil
    -- vim.keymap.del('n', 'K', { buffer = args.buf })
    -- vmap.set('n', '[[', function()
    --   lspwords.jump(-vv.count1, true)
    -- end, { silent = true, desc = '' })

    local client = vlsp.get_client_by_id(args.data.client_id)

    if client.supports_method('textDocument/documentHighlight') then
      vmap.set({ 'n' }, ']]', function() end, { silend = true, desc = 'Next reference' })
      vmap.set({ 'n' }, '[[', function() end, { silend = true, desc = 'Next reference' })
    end
  end,
})
