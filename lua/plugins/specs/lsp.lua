--- Here is all tooling to interactuate with LSP

return {
  --- List all diagnostics
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    dependencies = {
      {
        'folke/which-key.nvim',
        opts = {
          spec = {
            {
              {
                mode = { 'n' },
                { '<leader>x', group = 'Trouble', icon = '󱍼' },
              },
            },
          },
        },
      },
    },
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>xs', '<cmd>Trouble symbols toggle<cr>', desc = 'Symbols (Trouble)' },
      { '<leader>xS', '<cmd>Trouble lsp toggle<cr>', desc = 'LSP references/definitions/... (Trouble)' },
    },
  },

  --- LSP Config
  {
    'neovim/nvim-lspconfig',
    event = { 'LazyFile', 'VeryLazy' },
    dependencies = {
      "b0o/SchemaStore.nvim"
    },
    -- configure = require('plugins.configs.lspconfig-c')
  },

  --- Mason
  {
    'mason-org/mason.nvim',
    event = { 'LazyFile', 'VeryLazy' },
    opts = {
      ui = {
        icons = {
          package_installed = '🜍',
          package_pending = '🜛',
          package_uninstalled = 'x',
        },
        -- icons = {
        --   package_installed = '✓',
        --   package_pending = '➜',
        --   package_uninstalled = '✗',
        -- },
      },
    },
    cmd = {
      'Mason',
      'MasonInstall',
      'MasonUninstall',
      'MasonUninstallAll',
      'MasonUpdate',
      'MasonLog',
    },
  },

  --- Bridge with Mason and lspconfig
  {
    'mason-org/mason-lspconfig.nvim',
    lazy = false,
    opts = {
      ensure_installed = { "lua_ls" },
      automatic_enable = true,
    },
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'neovim/nvim-lspconfig',
    },
    cmd = {
      "LspInstall",
      "LspUninstall"
    }
  },

  --- None ls Format and lintters
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-null-ls").setup({
        ensure_installed = {
          ensure_installed = { "stylua", "jq" }
        },
        automatic_installation = false,
        handlers = {},
      })
      require("null-ls").setup({
        sources = {
        }
      })
    end,
  },

  --- LSP Saga

  --- Formatt and Lint
  -- {
  --   "nvimdev/guard.nvim",
  --   event = {
  --     "VeryLazy",
  --     -- "LazyFile"
  --   },
  --   dependencies = {
  --     "nvimdev/guard-collection"
  --   },
  --   config = require("plugins.configs.guard-c")
  -- },
}
