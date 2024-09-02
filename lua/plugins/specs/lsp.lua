return {

  --- Lsp config wrapper
  {
    'neovim/nvim-lspconfig',
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
