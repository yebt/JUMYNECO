local mroot = require('modules.root')
local lcutl = require("lazy.core.util")

local M = {}

function M.get_clients(opts)
  local ret = {}
  if vim.lsp.get_clients then
    ret = vim.lsp.get_clients(opts)
  else
    -- ret = vim.lsp.get_active_clients(opts)
    ret = vim.lsp.get_clients(opts)
    if opts and opts.method then
      ret = vim.tbl_filter(function(client)
        return client.supports_method(opts.method, { bufnr = opts.bufnr })
      end, ret)
    end
  end
  return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

function M.on_attach(on_attach, name)
  return vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and (not name or client.name == name) then
        return on_attach(client, buffer)
      end
    end,
  })
end

M._supports_method = {}

function M.setup()
  local register_capability = vim.lsp.handlers['client/registerCapability']
  vim.lsp.handlers['client/registerCapability'] = function(err, res, ctx)
    local ret = register_capability(err, res, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if client then
      for buffer in pairs(client.attached_buffers) do
        vim.api.nvim_exec_autocmds('User', {
          pattern = 'LspDynamicCapability',
          data = { client_id = client.id, buffer = buffer },
        })
      end
    end
    return ret
  end
  M.on_attach(M._check_methods)
  M.on_dynamic_capability(M._check_methods)
end

function M._check_methods(client, buffer)
  -- don't trigger on invalid buffers
  if not vim.api.nvim_buf_is_valid(buffer) then
    return
  end
  -- don't trigger on non-listed buffers
  if not vim.bo[buffer].buflisted then
    return
  end
  -- don't trigger on nofile buffers
  if vim.bo[buffer].buftype == 'nofile' then
    return
  end
  for method, clients in pairs(M._supports_method) do
    clients[client] = clients[client] or {}
    if not clients[client][buffer] then
      if client.supports_method and client.supports_method(method, { bufnr = buffer }) then
        clients[client][buffer] = true
        vim.api.nvim_exec_autocmds('User', {
          pattern = 'LspSupportsMethod',
          data = { client_id = client.id, buffer = buffer, method = method },
        })
      end
    end
  end
end

function M.on_dynamic_capability(fn, opts)
  return vim.api.nvim_create_autocmd('User', {
    pattern = 'LspDynamicCapability',
    group = opts and opts.group or nil,
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local buffer = args.data.buffer
      if client then
        return fn(client, buffer)
      end
    end,
  })
end

function M.on_supports_method(method, fn)
  M._supports_method[method] = M._supports_method[method] or setmetatable({}, { __mode = 'k' })
  return vim.api.nvim_create_autocmd('User', {
    pattern = 'LspSupportsMethod',
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local buffer = args.data.buffer
      if client and method == args.data.method then
        return fn(client, buffer)
      end
    end,
  })
end

function M.rename_file()
  local buf = vim.api.nvim_get_current_buf()
  local old = assert(mroot.realpath(vim.api.nvim_buf_get_name(buf)))
  local root = assert(mroot.realpath(mroot.get({ normalize = true })))
  assert(old:find(root, 1, true) == 1, 'File not in project root')

  local extra = old:sub(#root + 2)

  vim.ui.input({
    prompt = 'New File Name: ',
    default = extra,
    completion = 'file',
  }, function(new)
    if not new or new == '' or new == extra then
      return
    end
    new = lcutl.norm(root .. '/' .. new)
    vim.fn.mkdir(vim.fs.dirname(new), 'p')
    M.on_rename(old, new, function()
      vim.fn.rename(old, new)
      vim.cmd.edit(new)
      vim.api.nvim_buf_delete(buf, { force = true })
      vim.fn.delete(old)
    end)
  end)
end

function M.on_rename(from, to, rename)
  local changes = { files = { {
    oldUri = vim.uri_from_fname(from),
    newUri = vim.uri_from_fname(to),
  } } }

  local clients = M.get_clients()
  for _, client in ipairs(clients) do
    if client.supports_method('workspace/willRenameFiles') then
      local resp = client.request_sync('workspace/willRenameFiles', changes, 1000, 0)
      if resp and resp.result ~= nil then
        vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
      end
    end
  end

  if rename then
    rename()
  end

  for _, client in ipairs(clients) do
    if client.supports_method('workspace/didRenameFiles') then
      client.notify('workspace/didRenameFiles', changes)
    end
  end
end

function M.get_config(server)
  local configs = require('lspconfig.configs')
  return rawget(configs, server)
end

function M.is_enabled(server)
  local c = M.get_config(server)
  return c and c.enabled ~= false
end

function M.disable(server, cond)
  local util = require('lspconfig.util')
  local def = M.get_config(server)

  def.document_config.on_new_config = util.add_hook_before(def.document_config.on_new_config, function(config, root_dir)
    if cond(root_dir, config) then
      config.enabled = false
    end
  end)
end

function M.formatter(opts)
  opts = opts or {}
  local filter = opts.filter or {}
  filter = type(filter) == 'string' and { name = filter } or filter

  local ret = {
    name = 'LSP',
    primary = true,
    priority = 1,
    format = function(buf)
      M.format(lcutl.merge({}, filter, { bufnr = buf }))
    end,
    sources = function(buf)
      local clients = M.get_clients(lcutl.merge({}, filter, { bufnr = buf }))

      local ret = vim.tbl_filter(function(client)
        return client.supports_method('textDocument/formatting')
          or client.supports_method('textDocument/rangeFormatting')
      end, clients)

      return vim.tbl_map(function(client)
        return client.name
      end, ret)
    end,
  }
  return lcutl.merge(ret, opts) 
end

function M.format(opts)
  opts = vim.tbl_deep_extend(
    'force',
    {},
    opts or {},
    lcutl.opts('nvim-lspconfig').format or {},
    lcutl.opts('conform.nvim').format or {}
  )
  local ok, conform = pcall(require, 'conform')
  -- use conform for formatting with LSP when available,
  -- since it has better format diffing
  if ok then
    opts.formatters = {}
    conform.format(opts)
  else
    vim.lsp.buf.format(opts)
  end
end

M.words = {}
M.words.enabled = false
M.words.ns = vim.api.nvim_create_namespace('vim_lsp_references')

function M.words.setup(opts)
  opts = opts or {}
  if not opts.enabled then
    return
  end
  M.words.enabled = true
  local handler = vim.lsp.handlers['textDocument/documentHighlight']
  vim.lsp.handlers['textDocument/documentHighlight'] = function(err, result, ctx, config)
    if not vim.api.nvim_buf_is_loaded(ctx.bufnr) then
      return
    end
    vim.lsp.buf.clear_references()
    return handler(err, result, ctx, config)
  end

  M.on_supports_method('textDocument/documentHighlight', function(_, buf)
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI', 'CursorMoved', 'CursorMovedI' }, {
      group = vim.api.nvim_create_augroup('lsp_word_' .. buf, { clear = true }),
      buffer = buf,
      callback = function(ev)
        if not require('lazyvim.plugins.lsp.keymaps').has(buf, 'documentHighlight') then
          return false
        end

        if not ({ M.words.get() })[2] then
          if ev.event:find('CursorMoved') then
            vim.lsp.buf.clear_references()
          elseif not require('cmp').visible() then
            vim.lsp.buf.document_highlight()
          end
        end
      end,
    })
  end)
end

function M.words.get()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local current, ret = nil, {}
  for _, extmark in ipairs(vim.api.nvim_buf_get_extmarks(0, M.words.ns, 0, -1, { details = true })) do
    local w = {
      from = { extmark[2] + 1, extmark[3] },
      to = { extmark[4].end_row + 1, extmark[4].end_col },
    }
    ret[#ret + 1] = w
    if cursor[1] >= w.from[1] and cursor[1] <= w.to[1] and cursor[2] >= w.from[2] and cursor[2] <= w.to[2] then
      current = #ret
    end
  end
  return ret, current
end

function M.words.jump(count, cycle)
  local words, idx = M.words.get()
  if not idx then
    return
  end
  idx = idx + count
  if cycle then
    idx = (idx - 1) % #words + 1
  end
  local target = words[idx]
  if target then
    vim.api.nvim_win_set_cursor(0, target.from)
  end
end

M.action = setmetatable({}, {
  __index = function(_, action)
    return function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { action },
          diagnostics = {},
        },
      })
    end
  end,
})

function M.execute(opts)
  local params = {
    command = opts.command,
    arguments = opts.arguments,
  }
  if opts.open then
    require('trouble').open({
      mode = 'lsp_command',
      params = params,
    })
  else
    return vim.lsp.buf_request(0, 'workspace/executeCommand', params, opts.handler)
  end
end

return M
