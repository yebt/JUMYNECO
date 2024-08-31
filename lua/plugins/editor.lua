return {
  --- Iterator
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    opts = {},
  },

  --- Markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    event = { 'VeryLazy', 'LazyFile' },
    cmd = {
      'RenderMarkdown',
    },
  },
}
