local M = {}
--- Add blank space above
M.blank_above = function()
  vim.cmd("put! =repeat(nr2char(10), v:count1)|silent ']+")
end

--- Add blank space below
M.blank_below = function()
  vim.cmd("put =repeat(nr2char(10), v:count1)|silent '[-")
end

M.homeVsKey = function()
  local col = vim.fn.col('.')
  local line = vim.api.nvim_get_current_line()
  local nonBlankColumn = vim.fn.match(line, '\\S') + 1
  if col == nonBlankColumn then
    -- action = 'g0'
    action = '0'
  else
    -- if vim.opt_local.wrap._value then
    --   local current_line = vim.fn.line('.')
    --   local visual_start = vim.fn.virtcol('.')
    --   local visual_end = vim.fn.virtcol("$")
    --   print(current_line, visual_start, visual_end)
    --   -- local wrapped = visual_end > vim.api.nvim_win_get_width(0)
    --   -- if wrapped then
    --   --   action = 'g0'
    --   -- else
    --   --   action = '^'
    --   -- end
    --
    --   action = '^'
    -- else
    --   action = '^'
    -- end

    -- local wrap_staus = vim.opt_local.wrap._value
    -- local win_width = vim.api.nvim_win_get_width(0)
    action = '^'
  end
  return action
end

--- Remove buffer
M.brem = function()
  -- if there are less than 2
  if vim.fn.winnr('$') < 2 then
    vim.cmd('bw')
    return
  end
  -- there are at least 2 windows
  -- if there are less that 2 bufers
  if vim.fn.bufnr('$') < 2 then
    vim.cmd('enew')
  end
  vim.cmd('bn |  bw #')
end

--- Lazynvim buff remove
M.brem2 = function(buf)
  buf = buf or 0
  buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

  if vim.bo.modified then
    local choice = vim.fn.confirm(('Save changes to %q?'):format(vim.fn.bufname()), '&Yes\n&No\n&Cancel')
    if choice == 0 or choice == 3 then -- 0 for <Esc>/<C-c> and 3 for Cancel
      return
    end
    if choice == 1 then -- Yes
      vim.cmd.write()
    end
  end

  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    vim.api.nvim_win_call(win, function()
      if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
        return
      end
      -- Try using alternate buffer
      local alt = vim.fn.bufnr('#')
      if alt ~= buf and vim.fn.buflisted(alt) == 1 then
        vim.api.nvim_win_set_buf(win, alt)
        return
      end

      -- Try using previous buffer
      local has_previous = pcall(vim.cmd, 'bprevious')
      if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
        return
      end

      -- Create new listed buffer
      local new_buf = vim.api.nvim_create_buf(true, false)
      vim.api.nvim_win_set_buf(win, new_buf)
    end)
  end
  if vim.api.nvim_buf_is_valid(buf) then
    pcall(vim.cmd, 'bdelete! ' .. buf)
  end
end

--- Toggle netrw
M.toggleNetrw = function()
  -- Verificar si el buffer de netrw ya está abierto
  local netrw_buf_exists = false
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, 'filetype') == 'netrw' then
      netrw_buf_exists = true
      break
    end
  end

  -- Abrir Vexprore si el buffer de netrw no está abierto
  if not netrw_buf_exists then
    --vim.cmd("Vexplore")
    vim.cmd('Explore %:p:h')
  else
    -- Obtener el número del buffer actual
    local current_buf = vim.api.nvim_get_current_buf()

    -- Verificar si el buffer actual es netrw
    if vim.api.nvim_buf_get_option(current_buf, 'filetype') == 'netrw' then
      -- Cerrar el buffer actual
      vim.cmd('bd')
    else
      -- Enfocar el buffer de netrw
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.api.nvim_buf_get_option(buf, 'filetype') == 'netrw' then
          vim.api.nvim_set_current_win(win)
          break
        end
      end
    end
  end
end

M.surround = function()
  -- vim.notify(':➿:')
  print(':➿:')
  local char_code = vim.fn.getchar()
  local char = vim.fn.nr2char(char_code)
  if char == '\x03' or char == '\x1b' then
    return
  end
  local surrounds = {
    ['('] = ')',
    ['['] = ']',
    ['{'] = '}',
    ['<'] = '>',
    -- ' " ` = are the same
  }
  local pair_char = surrounds[char] or char
  return 'c' .. char .. '<C-r><C-o>"' .. pair_char .. '<ESC><Left>vi' .. char
end

--- Check if an plugin is available
M.plugin_is_available = function(pg)
  local lazy_config_avail, lazy_config = pcall(require, 'lazy.core.config')
  return lazy_config_avail and lazy_config.spec.plugins[pg] ~= nil
end

M.toggleMaximize = function()
  if not M._maximized then
    M._maximized = {}
    local function set(k, v)
      table.insert(M._maximized, 1, { k = k, v = vim.o[k] })
      vim.o[k] = v
    end
    set('winwidth', 999)
    set('winheight', 999)
    set('winminwidth', 10)
    set('winminheight', 4)
    vim.cmd('wincmd =')
    vim.api.nvim_create_autocmd('ExitPre', {
      once = true,
      group = vim.api.nvim_create_augroup('lazyvim_restore_max_exit_pre', { clear = true }),
      desc = 'Restore width/height when close Neovim while maximized',
      callback = function()
        M.maximize.set(false)
      end,
    })
  else
    for _, opt in ipairs(M._maximized) do
      vim.o[opt.k] = opt.v
    end
    M._maximized = nil
    vim.cmd('wincmd =')
  end
end

return M
