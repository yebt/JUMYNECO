return function(arg)
  local msag = vim.api.nvim_create_augroup('_mini_sessions', { clear = true })
  --- TODO: make a project session
  --- TODO: make a last session
  vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
    group = msag,
    desc = 'Try autosave the actual session',
    callback = function()
      --- Chekc if session is starter
      if vim.v.this_session ~= '' then
        return
      end

      local ignoreBuffers = { '' }
      --- Check if buffers
      local function get_buffers()
        local bffrs = {}
        local all_bffrs = vim.api.nvim_list_bufs()
        local buf_info = function(bfnr)
          local infs = vim.fn.getbufinfo(bfnr)
          if #infs == 0 then
            return nil
          end
          return infs[1]
        end

        for b in pairs(all_bffrs) do
          local inf = buf_info(b)
          --- ignore no listed buffers and empty buffs
          if inf.listed == 1 and inf.name ~= '' then
            table.insert(bffrs, b)
          end
        end
        return bffrs
      end

      local bfrs = get_buffers({ listed = true })

      --- Not trak if not buffs
      if #bfrs == 0 then
        return
      end

      local dir = vim.fn.getcwd()
      local home = vim.fn.expand('~')
      local branch = vim.trim(vim.fn.system('git branch --show-current'))
      branch = vim.v.shell_error == 0 and branch or nil

      local sname = dir:gsub(home, '~'):gsub('/', '%%') .. (branch and '%%' .. branch or '')
      local ms = require('mini.sessions')
      --- Not track if is just one file but is not tracked before
      if #bfrs == 1 and not ms.detected[sname] then
        return
      end
      ms.write(sname, { force = true, verbose = false })
      ms.write('last', { force = true, verbose = false })
    end,
  })
end
