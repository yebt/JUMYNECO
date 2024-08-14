return function()
  local night_owl = require('night-owl')

  -- 👇 Add your own personal settings here
  --@param options Config|nil
  night_owl.setup({
    -- These are the default settings
    bold = true,
    italics = true,
    underline = true,
    undercurl = true,
    transparent_background = false,
  })
  vim.cmd.colorscheme('night-owl')
end
