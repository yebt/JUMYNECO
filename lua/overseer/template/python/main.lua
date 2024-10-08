return {
  name = 'PRM',
  description = 'Python run main.py file',
  builder = function()
    local file = vim.fn.expand('%:p')
    return {
      cmd = { 'python3', file },
      args = {},
      components = {
        -- {
        --   "on_complete_notify",
        --   open = true,
        -- },
        {
          'open_output',
          direction = 'dock',
        },
        -- {
        --   "display_duration",
        --   detail_level = 1,
        -- },

        -- {
        --   "on_output_quickfix",
        --   open = true,
        -- },
        'default',
      },
    }
  end,
  condition = {
    filetype = { 'python' },
  },
}
