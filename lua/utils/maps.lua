--- ----------------------------------------
--- Funtions to execute with the mappings
--- ----------------------------------------

local M = {}
-- Add blank space above
M.blank_above = function()
  vim.cmd("put! =repeat(nr2char(10), v:count1)|silent ']+")
end

-- Add blank space below
M.blank_below = function()
  vim.cmd("put =repeat(nr2char(10), v:count1)|silent '[-")
end

M.homeVsKey = function()
  local col = vim.fn.col('.')
  local line = vim.api.nvim_get_current_line()
  local nonBlankColumn = vim.fn.match(line, '\\S') + 1
  if col == nonBlankColumn then
    action = 'g0'
  else
    action = '^'
  end
  return action
end

-- Remove buffer
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

-- Toggle netrw
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

-- Check if an plugin is available
M.plugin_is_available = function(pg)
  local lazy_config_avail, lazy_config = pcall(require, 'lazy.core.config')
  return lazy_config_avail and lazy_config.spec.plugins[pg] ~= nil
end

return M
