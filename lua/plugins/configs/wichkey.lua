return function()
  require('which-key').setup({
    ---@type false | "classic" | "modern" | "helix"
    preset = 'classic',
    win = {
      height = { min = 4, max = 10 },
      border = 'single',
    },
    icons = {},
  })
end
