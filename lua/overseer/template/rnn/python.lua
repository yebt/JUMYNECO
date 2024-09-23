return {
  name = 'python runner',
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
          direction = 'dock', -- "dock"|"float"|"tab"|"vertical"|"horizontal"
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
