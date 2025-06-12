local M = {}


---Ejecuta un comando LSP SOLO sobre el cliente Intelephense.
---@param client vim.lsp.Client
---@param cmd string
---@param args table|nil
local function exec(client, cmd, args)
  return function()
    if client.server_capabilities.executeCommandProvider then
      -- client:exec_cmd(
      --   cmd,
      --   {bufnr = 0},
      --   function (err,res)
      --     if err then
      --       vim.print(err)
      --     end
      --     vim.print(res)
      --   end
      -- )

      -- client.request(
      --   'workspace/executeCommand',
      --   { command = cmd, arguments = args },
      --   function(err, ) if err then vim.notify(err.message, vim.log.levels.ERROR) end end
      -- )
      client:request(
        'workspace/executeCommand',
        -- {command = cmd, arguments = args},
        { command = cmd, arguments = args },
        function (err, res)
          if err then
            vim.notify(err.message, vim.log.levels.ERROR)
          end
          vim.print(res)
        end
      )
    else
      vim.notify('Intelephense no soporta ' .. cmd, vim.log.levels.WARN)
    end
  end
end


---Crea user-commands y keymaps cuando se adjunta Intelephense.
function M.setup(client, bufnr)
  if client.name ~= 'intelephense' then return end

  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end
  local cmd = function(name, fun, desc)
    vim.api.nvim_buf_create_user_command(bufnr, name, fun, { desc = desc })
  end

  -- Index / Cancel
  cmd('IntelephenseIndex',  exec(client, 'intelephense.index.workspace'), 'Re-index workspace')
  cmd('IntelephenseCancel', exec(client, 'intelephense.cancel.indexing'), 'Cancelar indexado')
  -- map('n', '<leader>pi', exec(client, 'intelephense.index.workspace'),  'Intelephense: index')
  -- map('n', '<leader>pc', exec(client, 'intelephense.cancel.indexing'), 'Intelephense: cancel')

  -- PHPUnit
  cmd('PhpUnit',        exec(client, 'intelephense.phpunit.projectTest'), 'PHPUnit proyecto')
  cmd('PhpUnitFile',    exec(client, 'intelephense.phpunit.fileTest',
                             { vim.api.nvim_buf_get_name(bufnr) }),
                             'PHPUnit archivo')
  cmd('PhpUnitNearest', exec(client, 'intelephense.phpunit.singleTest'),  'PHPUnit método')
  -- map('n', '<leader>pt', exec(client, 'intelephense.phpunit.fileTest',
  --                             { vim.api.nvim_buf_get_name(bufnr) }),
  --                             'Test archivo')
  -- map('n', '<leader>pe', exec(client, 'intelephense.phpunit.singleTest'), 'Test método')

  -- Refactoring helpers
  cmd('PhpFixClass',      exec(client, 'intelephense.fixClassName'),       'Fix class name')
  cmd('PhpFixNamespace',  exec(client, 'intelephense.fixNamespace'),       'Fix namespace')
  cmd('PhpCtorComplete',  exec(client, 'intelephense.completeConstructor'),'Completar constructor')
end

return M
