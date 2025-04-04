return {
  {
    'windwp/nvim-ts-autotag',
    event = { 'LazyFile', 'VeryLazy' },
    opts = {
      opts = {
        -- Defaults
        enable_close = true,      -- Auto close tags
        enable_rename = true,     -- Auto rename pairs of tags
        enable_close_on_slash = true -- Auto close on trailing </
      },
      -- Also override individual filetype configs, these take priority.
      -- Empty by default, useful if one of the "opts" global settings
      -- doesn't work well in a specific filetype
      per_filetype = {
        -- ["html"] = {
        --   enable_close = false
        -- }
      }
    }
  },

  -- NOTE: this plugin is not working cause error in mini.files
  -- {
  --   'leafOfTree/vim-matchtag',
  --   lazy = false,
  --   -- event = { 'LazyFile', 'VeryLazy' },
  -- }
}
