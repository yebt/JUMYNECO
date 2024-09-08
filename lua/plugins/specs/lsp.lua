return {

  --- Lsp config wrapper
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      --- Packages
      {
        'williamboman/mason.nvim',
        cmd = { 'Mason', 'MasonUpdate', 'MasonInstall', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
      },
      --- Bridge
      {
         "williamboman/mason-lspconfig.nvim",
         cmd = {'LspInstall', 'LspUninstall'}
      }
    },
    event = {"VeryLazy"},
    config = require('plugins.configs.lspc'),
  },

  --- LSP Iteration Utils
  {
    'nvimdev/lspsaga.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons', -- optional
    },
    -- event = "LazyFile",
    event = { 'LspAttach' },
    config = require('plugins.configs.lspsaga'),
  },
}
