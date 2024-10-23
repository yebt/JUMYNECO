return function()
  local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

  local msn = require('mason')
  local msnnls = require('mason-null-ls')
  local nls = require('null-ls')
  local util = vim.lsp.util
  local api = vim.api

  -- msn.setup()

  -- local async_formatting = function(bufnr)
  --   bufnr = bufnr or vim.api.nvim_get_current_buf()
  --
  --   vim.lsp.buf_request(
  --     bufnr,
  --     'textDocument/formatting',
  --     vim.lsp.util.make_formatting_params({}),
  --     function(err, res, ctx)
  --       if err then
  --         local err_msg = type(err) == 'string' and err or err.message
  --         -- you can modify the log message / level (or ignore it completely)
  --         vim.notify('formatting: ' .. err_msg, vim.log.levels.WARN)
  --         return
  --       end
  --
  --       -- don't apply results if buffer is unloaded or has been modified
  --       if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_get_option_value('modified', { buf = bufnr }) then
  --         return
  --       end
  --
  --       if res then
  --         local client = vim.lsp.get_client_by_id(ctx.client_id)
  --         vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or 'utf-16')
  --         vim.api.nvim_buf_call(bufnr, function()
  --           vim.cmd('silent noautocmd update')
  --         end)
  --       end
  --     end
  --   )
  -- end

  msnnls.setup({
    ensure_installed = {
      -- Opt to list sources here, when available in mason.
    },
    automatic_installation = false,
    handlers = {},
  })
  nls.setup({
    sources = {
      -- Anything not supported by mason.
      require('plugins.configs.nonels-sources.autopep8'),
    },
    -- on_attach = function(client, bufnr)
    --   if client.supports_method('textDocument/formatting') then
    --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    --     vim.api.nvim_create_autocmd('BufWritePre', {
    --       group = augroup,
    --       buffer = bufnr,
    --       callback = function(args)
    --         vim.notify(vim.inspect(vim.lsp.buf.format({ bufnr = args.buf, async = false })))
    --       end,
    --     })
    --   end
    -- end,

    -- on_attach = function(client, bufnr)
    --   if client.supports_method('textDocument/formatting') then
    --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    --     -- vim.notify(vim.inspect(client))
    --     -- vim.api.nvim_create_autocmd('BufWritePost', {
    --     --   group = augroup,
    --     --   buffer = bufnr,
    --     --   callback = function()
    --     --     async_formatting(bufnr)
    --     --   end,
    --     -- })
    --   end
    -- end,
  })

  local function overwrite_format2(options)
    options = options or {
      -- timeout_ms = 3000,
    }
    local bufnr = options.bufnr or api.nvim_get_current_buf()
    local method = 'textDocument/formatting'
    -- local clients = vim.lsp.get_active_clients({
    --   id = options.id,
    --   bufnr = bufnr,
    --   name = options.name,
    --   method = method,
    -- })
    local clients = vim.lsp.get_clients({
      id = options.id,
      bufnr = bufnr,
      name = options.name,
      method = method,
    })

    if options.filter then
      clients = vim.tbl_filter(options.filter, clients)
    end
    -- filer if client.server_capabilities.documentFormattingProvider
    clients = vim.tbl_filter(function(client)
      return client.server_capabilities.documentFormattingProvider
    end, clients)

    if #clients == 0 then
      vim.notify('[LSP] Format request failed, no matching language servers.')
    end

    local copyClient = vim.deepcopy(clients)
    table.insert(copyClient, { name = 'all' })
    table.insert(copyClient, { name = 'Set default formatter' })

    --@private
    local function applyFormat(clientsi)
      if options.async then
        local do_format
        do_format = function(idx, client)
          if not client then
            return
          end
          -- local params = set_range(client, util.make_formatting_params(options.formatting_options))
          local params = util.make_formatting_params(options.formatting_options)
          client.request(method, params, function(...)
            local handler = client.handlers[method] or vim.lsp.handlers[method]
            handler(...)
            do_format(next(clientsi, idx))
          end, bufnr)
        end
        do_format(next(clientsi))
      else
        local timeout_ms = options.timeout_ms or 1000
        for _, client in pairs(clientsi) do
          local params = util.make_formatting_params(options.formatting_options)
          local result, err = client.request_sync(method, params, timeout_ms, bufnr)
          if result and result.result then
            util.apply_text_edits(result.result, bufnr, client.offset_encoding)
          end
          if err then
            vim.notify(string.format('[LSP][%s] %s', client.name, err), vim.log.levels.WARN)
          end
        end
      end
    end

    -- check if formatter is set
    if vim.g.defaultFormatClient then
      -- check if formatter is in list
      for _, client in pairs(clients) do
        if client.name == vim.g.defaultFormatClient then
          applyFormat({ client })
          return
        end
      end
      vim.notify('Default Formatter not found: ' .. vim.g.defaultFormatClient)
    end

    if #clients > 1 then
      vim.ui.select(copyClient, {
        prompt = 'Select a formatter:',
        format_item = function(item)
          return item.name
        end,
      }, function(choice)
        if not choice then
          vim.notify('No formatter selected')
        elseif choice.name == 'all' then
          applyFormat(clients)
        elseif choice.name == 'Set default formatter' then
          vim.ui.select(clients, {
            prompt = 'Select a formatter:',
            format_item = function(item)
              return item.name
            end,
          }, function(choicei)
            if not choicei then
              vim.notify('No formatter selected')
            else
              vim.notify('Set default formatter:' .. choicei.name)
              vim.g.defaultFormatClient = choicei.name
              applyFormat({ choicei })
            end
          end)
        elseif choice then
          applyFormat({ choice })
        end
      end)
    else
      applyFormat(clients)
    end
  end

  -- vim.keymap.set('n', function(args) end, { silent = true, desc = 'None ls Format' })
  vim.keymap.set('n', '<leader>f', function()
    overwrite_format2({
      async = true,
    })
  end, { silent = true, desc = 'None ls Format' })

  vim.keymap.set('n', '<leader>gq', function()
    overwrite_format2({
      async = true,
    })
    -- vim.lsp.buf.format()
    -- local clients_in_buf = vim.lsp.get_clients({
    --   method = 'textDocument/formatting',
    -- })
    --
    -- local client_names = vim.tbl_map(function(cl)
    --   return cl.name
    -- end, clients_in_buf)
    --
    -- vim.notify(vim.inspect(client_names))
    -- vim.ui.select
    -- vim.lsp.buf.format({
    --   filter = function (client)
    --
    --   end
    -- })

    -- vim.notify(vim.inspect(args))
    -- vim.ui.select({})
    --     vim.ui.select({ 'tabs', 'spaces' }, {
    --     prompt = 'Select tabs or spaces:',
    --     format_item = function(item)
    --         return "I'd like to choose " .. item
    --     end,
    -- }, function(choice)
    --     if choice == 'spaces' then
    --         vim.o.expandtab = true
    --     else
    --         vim.o.expandtab = false
    --     end
    -- end)
  end, { silent = true, desc = 'None ls formatter' })
end
