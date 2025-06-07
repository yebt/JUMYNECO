local path_concat = require('modules.utils').path_concat
local licence_path = path_concat({
  vim.fn.expand('~'),
  'intelephense/licence.txt'
})

return {
  init_options = {
    licenceKey = licence_path
  },

  settings = {
    intelephense = {
      diagnostics = {
        enable = true,
      },
      format = {
        enable = true,
      },
    },
  },

}
