return {

  --- Lsp config wrapper
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      --- Packages
      'williamboman/mason.nvim',
      --- Bridge
      'williamboman/mason-lspconfig.nvim',
    },
    event = { 'VeryLazy' },
    config = require('plugins.configs.lspc'),
  },

  --- Packages
  {
    'williamboman/mason.nvim',
    cmd = { 'Mason', 'MasonUpdate', 'MasonInstall', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },

  --- Bridge Mason and Nvm-LSPConfig
  {
    'williamboman/mason-lspconfig.nvim',
    cmd = { 'LspInstall', 'LspUninstall' },
    opts = {
      ensure_installed = { 'lua_ls' },
    },
  },

  --- LSP Iteration Utils
  {
    'nvimdev/lspsaga.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
    },
    cmd = { 'Lspsaga' },
    -- event = "LazyFile",
    event = { 'LspAttach' },
    config = require('plugins.configs.lspsaga'),
  },

  --- Formatter
  --- Guard is problematic
  -- {
  --   'nvimdev/guard.nvim',
  --   -- Builtin configuration, optional
  --   dependencies = {
  --     'nvimdev/guard-collection',
  --     'williamboman/mason.nvim',
  --   },
  --   cmd = {
  --     'GuardFmt',
  --     'GuardDisable',
  --     'GuardEnable',
  --   },
  --   event = 'VeryLazy',
  --   config = require('plugins.configs.guardc'),
  -- },

  --- Formatter
  -- {
  --   'stevearc/conform.nvim',
  --   -- TODO: load all available formatter for the current file
  --   keys = {'<leader>f'},
  --   config = require("plugins.configs.conformc")
  -- },

  --- Null
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',

      'nvimtools/none-ls.nvim',
      'nvim-lua/plenary.nvim',
    },
    keys = {
       {'<leader>gq', desc = "None ls format"}
    },
    config = require('plugins.configs.nonels'),
  },
}
