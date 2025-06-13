local types = require('blink.cmp.types')

local Source = {}
function Source.new(_opts) return setmetatable({}, { __index = Source }) end
function Source:enabled() return vim.bo.filetype == 'php' end
function Source:get_trigger_characters() return { '*' } end

---@param ctx blink.cmp.Context
function Source:get_completions(ctx, cb)
  -- vim.print(ctx)
  local row = ctx.cursor[1]
  local col = ctx.cursor[2]
  local line = vim.api.nvim_get_current_line():sub(1, col)
  if line:sub(-3) == '/**' then
    cb({
      items = {
        {
          label = '/** [Intelephense PHPDoc] */',
          kind = types.CompletionItemKind.Snippet,
          insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
          textEdit = {
            newText = '/**\n * $0\n */',
            range = {
              start = { line = row - 1, character = col - 3 },
              ['end'] = { line = row - 1, character = col },
            },
          },
        },
      },
    })
  else
    cb({ items = {} })
  end
end

return Source
