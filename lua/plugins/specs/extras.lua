-- Extras work
return {
  --- Snacks
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    -- event = 'VeryLazy',
    opts = {
      --
      bigfile = {
        -- your bigfile configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        enabled = true,
        notify = true,            -- show notification when big file detected
        size = 1.5 * 1024 * 1024, -- 1.5MB
      },

      dashboard = {
        enabled = true,
        example = "github"
      },
      scroll = {
        -- your scroll configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        enabled = true,
      },
      quickfile = {
        enabled = true
        -- your quickfile configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      explorer = {
        -- your explorer configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        enabled = true,
      },
      picker = {
        sources = {
          explorer = {
            -- your explorer picker configuration comes here
            -- or leave it empty to use the default settings
          }
        }
      }

    }
  }

}
