local api = vim.api
local uv = vim.uv

local strive = require('strive')

-- _G.strive_plugins = {}
--
-- local original_use = strive.use
-- strive.use = function(spec)
--   local plugin = original_use(spec)
--   table.insert(_G.strive_plugins, plugin)
--   return plugin
-- end
--
-- api.nvim_create_user_command("StriveList", function()
--   -- for _, plugin in ipairs(_G.strive_plugins or {}) do
--   --   print(string.format("%-40s %-10s", plugin.name, plugin.status or 'unknown'))
--   -- end
--
--   local plugins = _G.strive_plugins
--   local lines = {}
--   table.insert(lines, string.format('%-40s %-12s %s', 'Plugin', 'Estado', 'Ruta'))
--   table.insert(lines, string.rep('=', 80))
--
--   for _, plugin in ipairs(plugins) do
--     local name = plugin.name
--     local status = plugin.status or 'unknown'
--     local path = plugin:get_path()
--     table.insert(lines, string.format('%-40s %-12s %s', name, status, path))
--   end
--
--   -- Mostrar la salida en un nuevo buffer flotante
--   local buf = vim.api.nvim_create_buf(false, true)
--   vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
--   vim.bo[buf].buftype = 'nofile'
--   vim.bo[buf].bufhidden = 'wipe'
--   vim.bo[buf].modifiable = false
--   vim.api.nvim_open_win(buf, true, {
--     relative = 'editor',
--     width = math.floor(vim.o.columns * 0.8),
--     height = math.min(#lines + 2, math.floor(vim.o.lines * 0.5)),
--     row = math.floor((vim.o.lines - #lines) / 2),
--     col = math.floor(vim.o.columns * 0.1),
--     style = 'minimal',
--     border = 'rounded',
--     title = 'Strive Plugin List',
--     title_pos = 'center',
--   })
-- end, {})
--

local use = strive.use

require("plugins.specs.ui")(use)
require("plugins.specs.clrs")(use)

-- :run('Dashboard')



