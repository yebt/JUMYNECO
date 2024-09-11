local vlsp, vapi, vbo = vim.lsp, vim.api, vim.bo
local M = {}

M._supports_method = {}

function M._check_methods(client, buffer)
  -- don't trigger on invalid buffers
  if not vapi.nvim_buf_is_valid(buffer) then
    return
  end
  -- don't trigger on non-listed buffers
  if not vbo[buffer].buflisted then
    return
  end
  -- don't trigger on nofile buffers
  if vbo[buffer].buftype == "nofile" then
    return
  end
  for method, clients in pairs(M._supports_method) do
    clients[client] = clients[client] or {}
    if not clients[client][buffer] then
      if client.supports_method and client.supports_method(method, { bufnr = buffer }) then
        clients[client][buffer] = true
        vapi.nvim_exec_autocmds("User", {
          pattern = "LspSupportsMethod",
          data = { client_id = client.id, buffer = buffer, method = method },
        })
      end
    end
  end
end

function M.on_attach(on_attach, name)
  return vapi.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf ---@type number
      local client = vlsp.get_client_by_id(args.data.client_id)
      if client and (not name or client.name == name) then
        return on_attach(client, buffer)
      end
    end,
  })
end

function M.on_dynamic_capability(fn, opts)
  return vapi.nvim_create_autocmd("User", {
    pattern = "LspDynamicCapability",
    group = opts and opts.group or nil,
    callback = function(args)
      local client = vlsp.get_client_by_id(args.data.client_id)
      local buffer = args.data.buffer ---@type number
      if client then
        return fn(client, buffer)
      end
    end,
  })
end


function M.setup()
  local register_capability = vlsp.handlers["client/registerCapability"]
  vlsp.handlers["client/registerCapability"] = function(err, res, ctx)
    ---@diagnostic disable-next-line: no-unknown
    local ret = register_capability(err, res, ctx)
    local client = vlsp.get_client_by_id(ctx.client_id)
    if client then
      for buffer in pairs(client.attached_buffers) do
        vapi.nvim_exec_autocmds("User", {
          pattern = "LspDynamicCapability",
          data = { client_id = client.id, buffer = buffer },
        })
      end
    end
    return ret
  end
  M.on_attach(M._check_methods)
  M.on_dynamic_capability(M._check_methods)
end


function M.on_supports_method(method, fn)
  M._supports_method[method] = M._supports_method[method] or setmetatable({}, { __mode = "k" })
  return vapi.nvim_create_autocmd("User", {
    pattern = "LspSupportsMethod",
    callback = function(args)
      local client = vlsp.get_client_by_id(args.data.client_id)
      local buffer = args.data.buffer ---@type number
      if client and method == args.data.method then
        return fn(client, buffer)
      end
    end,
  })
end

M.words = {}
M.words.enabled = false
M.words.ns = vapi.nvim_create_namespace("vlsp_references")

function M.words.setup()
  M.words.enabled = true
  local handler = vlsp.handlers["textDocument/documentHighlight"]
  vlsp.handlers["textDocument/documentHighlight"] = function(err, result, ctx, config)
    if not vapi.nvim_buf_is_loaded(ctx.bufnr) then
      return
    end
    vlsp.buf.clear_references()
    return handler(err, result, ctx, config)
  end

  M.on_supports_method("textDocument/documentHighlight", function(_, buf)
    vapi.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" }, {
      group = vapi.nvim_create_augroup("lsp_word_" .. buf, { clear = true }),
      buffer = buf,
      callback = function(ev)
        -- if not require("lazyvim.plugins.lsp.keymaps").has(buf, "documentHighlight") then
        --   return false
        -- end

        if not ({ M.words.get() })[2] then
          if ev.event:find("CursorMoved") then
            vlsp.buf.clear_references()
          elseif not require("cmp").visible() then
            vlsp.buf.document_highlight()
          end
        end
      end,
    })
  end)
end

function M.words.get()
  local cursor = vapi.nvim_win_get_cursor(0)
  local current, ret = nil, {}
  for _, extmark in ipairs(vapi.nvim_buf_get_extmarks(0, M.words.ns, 0, -1, { details = true })) do
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
    vapi.nvim_win_set_cursor(0, target.from)
  end
end

return M
