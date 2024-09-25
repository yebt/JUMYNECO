return {
  name = 'PRCF',
  description = 'Python run current file',
  builder = function()
    local file = vim.fn.expand('%:p')
    return {
      cmd = { 'python3', file },
      args = {},
      components = {
        {
          'open_output',
          direction = 'dock',
        },
        'default',
      },
    }
  end,
  condition = {
    filetype = { 'python' },
  },
}
