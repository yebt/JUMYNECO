return {

  --- Neotest
  -- {
  --   "nvim-neotest/neotest",
  --   lazy = false,
  --   dependencies = {
  --     "nvim-neotest/nvim-nio",
  --     "nvim-lua/plenary.nvim",
  --     "antoinemadec/FixCursorHold.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --
  --     -- adapters
  --     "olimorris/neotest-phpunit", -- phpunit
  --     "V13Axel/neotest-pest",      -- pest
  --     "marilari88/neotest-vitest", -- vitest
  --   },
  --   keys = {
  --     {
  --       '<leader>tr',
  --       function()
  --         require("neotest").run.run()
  --       end,
  --       desc = "Neotest run"
  --     },
  --     {
  --       '<leader>tf',
  --       function()
  --         require("neotest").run.run(vim.fn.expand("%"))
  --       end,
  --       desc = "Neotest run current file"
  --     },
  --     {
  --       '<leader>ts',
  --       function()
  --         require("neotest").run.stop()
  --       end,
  --       desc = "Neotest stop"
  --     },
  --
  --   },
  --   confing = require("plugins.configs.neotestc")
  -- }
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      ---
      "olimorris/neotest-phpunit", -- phpunit
      "V13Axel/neotest-pest",      -- pest
      "marilari88/neotest-vitest", -- vitest
    },
    keys = {
      {
        '<leader>tr',
        function()
          require("neotest").run.run()
        end,
        desc = "Neotest run"
      },
      {
        '<leader>tf',
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Neotest run current file"
      },
      {
        '<leader>ts',
        function()
          require("neotest").run.stop()
        end,
        desc = "Neotest stop"
      },
      {
        '<leader>tS',
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Neotest summary toggle"
      },
      {
        '<leader>to',
        function ()
          require('neotest').output.open({short=false, auto_close=true})
        end,
        desc = "Neotest summary open output"
      }
    },
    config = require("plugins.configs.neotestc")
  }
}
