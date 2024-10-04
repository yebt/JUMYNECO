return function()
  require('which-key').setup({
    ---@type false | "classic" | "modern" | "helix"
    preset = 'helix',
    win = {
      -- don't allow the popup to overlap with the cursor
      no_overlap = true,
      -- width = 0.2,
      -- height = { min = 4, max = 25 },
      -- col = 0,
      -- row = math.huge,
      -- border = "none",
      padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
      title = true,
      title_pos = 'center',
      zindex = 1000,
      -- Additional vim.wo and vim.bo options
      bo = {},
      wo = {
        -- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
      },
    },
    layout = {
      width = {
        min = 20,
        max = 30
      }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
    },

    -- win = {
    --   height = { min = 4, max = 16 },
    --   border = 'single',
    -- },
    icons = {
      mappings = false,
    },
  })
end
