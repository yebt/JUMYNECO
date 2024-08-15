---------------------------------------------
--- Plugins for usage. no more
---------------------------------------------

return {

  --- Better view for markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    event = { 'VeryLazy', 'LazyFile' },
    cmd = {
      'RenderMarkdown',
    },
  },
}
