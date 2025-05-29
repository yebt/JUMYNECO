local M = {}
local redraw = require("modeline.redraw")

local mode_map = {
  n = "NORMAL", i = "INSERT", v = "VISUAL", V = "V-LINE", [""] = "V-BLOCK",
  c = "COMMAND", R = "REPLACE", t = "TERMINAL",
}

function M.get()
  local mode = vim.api.nvim_get_mode().mode
  local label = mode_map[mode] or mode
  return "%#ModelineMode# " .. label .. " "
end

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*",
  callback = redraw.schedule,
})

return M
