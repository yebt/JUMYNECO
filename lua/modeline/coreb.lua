local config = require("modeline.config")

local function get_module_output(name)
  local ok, mod = pcall(require, "modeline.modules." .. name)
  if ok and mod and mod.get then
    return mod.get()
  end
  return ""
end

local function render_section(modules, separator)
  local parts = {}
  for _, name in ipairs(modules) do
    local output = get_module_output(name)
    if output and output ~= "" then
      table.insert(parts, output)
    end
  end
  return table.concat(parts, separator or "%#ModelineSeparator# | %#Normal#")
end

local function render()
  local sections = config.get_sections()

  local left = render_section(sections.left)
  local center = render_section(sections.center)
  local right = render_section(sections.right)

  local full_line = table.concat({
    "%#Normal#", -- reset to normal
    left,
    "%=",
    center,
    "%=",
    right,
  }, " ")

  return full_line
end

return {
  render = render,
}

