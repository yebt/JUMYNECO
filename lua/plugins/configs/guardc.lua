return function()
  local ft = require('guard.filetype')
  local lint = require('guard.lint')

  ft('lua'):fmt('lsp'):append('stylua')

  local severities = {
    error = 1,
    warning = 2,
    info = 3,
    style = 4,
  }
  ---
  --[[
  {
    -- specify an executable
    cmd              -- string: tool command
    args             -- string[]: command arguments
    fname            -- boolean: insert filename to args tail
    stdin            -- boolean: pass buffer contents into stdin

    -- or provide your own logic
    fn               -- function: write your own logic for formatting / linting, more in ADVANCED.md

    -- running condition
    ignore_patterns  -- string|string[]: don't run formatter when pattern match against file name
    ignore_error     -- boolean: when has lsp error ignore format
    find             -- string|string[]: format if the file is found in the lsp root dir

    -- misc
    env              -- table<string, string>?: environment variables passed to cmd (key value pair)
    timeout          -- integer

    -- special
    parse            -- function: linter only, parses linter output to neovim diagnostic
  }
  --]]

  local function markdownlint_lint(acc)
    local co = assert(coroutine.running())
    local handle = vim.system({
      ---cmd
      'markdownlint',
      ---args
      '--stdin',
      '--json',
    }, {
      stdin = true,
    }, function(result)
      -- if result.code > 1 and #result.stderr > 0 then
      --   -- error
      --   coroutine.resume(co, result)
      -- else
      --   --- wake coroutine on exit, omit error checking
      -- end
      coroutine.resume(co, result.stderr)
    end)

    -- write contents to stdin and close it
    handle:write(acc)
    handle:write(nil)
    --- sleep util awakened after process finished
    return coroutine.yield()
  end

  local markdownlint_diagnostic_parse = lint.from_json({
    get_diagnostics = function(rslt)
      local json = vim.json.decode(rslt)
      vim.print(vim.inspect(rslt))
      if not vim.tbl_isempty(json) then
        -- vim.print(vim.inspect(json))
        return json
      end
      return {}
    end,
    lines = false, -- cause could be not load from each lines
    attributes = {
      -- it is json turned into a lua table
      lnum = function(it) -- OK
        return it.lineNumber
      end,
      -- lnum_end = function(it) -- OK
      --   vim.print(vim.inspect('lnum_end'))
      --   return 5
      -- end,
      code = function(it) -- Ok
        return it.ruleNames and (it.ruleNames[1] .. '/' .. it.ruleNames[2]) or ''
      end,
      col = function(it) -- OK
        return it.errorRange ~= vim.NIL and it.errorRange[1] or 1
      end,
      col_end = function(it)
        return it.errorRange ~= vim.NIL and it.errorRange[2] or 1
      end,
      severity = function(_) -- OK
        return 'warning'
      end,
      message = function(it) --OK
        return it.ruleDescription
      end,
    },
  })

  ft('markdown'):lint({
    -- cmd = 'markdownlint',
    -- args = { '--stdin' },
    fn = markdownlint_lint,
    stdin = true,
    parse = markdownlint_diagnostic_parse,
  })

  require('guard').setup({
    -- Choose to format on every write to a buffer
    fmt_on_save = false,
    -- Use lsp if no formatter was defined for this filetype
    lsp_as_default_formatter = true,
    -- By default, Guard writes the buffer on every format
    -- You can disable this by setting:
    -- save_on_fmt = false,
  })

  -- local is_formatting = false
  -- _G.guard_status = function()
  --   -- display icon if auto-format is enabled for current buffer
  --   local au = vim.api.nvim_get_autocmds({
  --     group = 'Guard',
  --     buffer = 0,
  --   })
  --   if ft[vim.bo.ft] and #au ~= 0 then
  --     -- return is_formatting and '' or ''
  --     return is_formatting and '' or '󰞀'
  --   end
  --   return ''
  -- end
  -- -- sets a super simple statusline when entering a buffer
  -- vim.cmd('au BufEnter * lua vim.opt.stl = [[%f %m ]] .. guard_status()')
  -- -- update statusline on GuardFmt event
  -- vim.api.nvim_create_autocmd('User', {
  --   pattern = 'GuardFmt',
  --   callback = function(opt)
  --     -- receive data from opt.data
  --     is_formatting = opt.data.status == 'pending'
  --     vim.opt.stl = [[%f %m ]] .. guard_status()
  --   end,
  -- })

  vim.api.nvim_create_autocmd('User', {
    pattern = 'GuardFmt',
    callback = function(opt)
      vim.notify(vim.inspect(opt))
    end,
  })
end
