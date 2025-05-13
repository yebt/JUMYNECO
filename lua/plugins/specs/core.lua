return {

  --- Good practices
  {
    'm4xshen/hardtime.nvim',
    event = 'BufEnter',
    priority = 10000,
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    -- lazy = false,
    config = require('plugins.configs.hard'),
  },

  --- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    version = false, -- last release is way too old and doesn't work on Windows
    build = ':TSUpdate',
    -- event = { 'LazyFile', 'VeryLazy' },
    event = { 'VeryLazy' },
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require('lazy.core.loader').add_to_rtp(plugin)
      require('nvim-treesitter.query_predicates')
    end,
    config = require('plugins.configs.treesitterc'),
  },

  --- TS Comments
  -- {
  --   'folke/ts-comments.nvim',
  --   -- lazy=false,
  --   event = "VeryLazy",
  --   -- dependencies={
  --   --   'nvim-treesitter/nvim-treesitter',
  --   -- },
  --   opts = {
  --     lang = {
  --       smarty = '{* %s *}',
  --       astro = '<!-- %s -->',
  --       axaml = '<!-- %s -->',
  --       blueprint = '// %s',
  --       c = '// %s',
  --       c_sharp = '// %s',
  --       clojure = { ';; %s', '; %s' },
  --       cpp = '// %s',
  --       cs_project = '<!-- %s -->',
  --       cue = '// %s',
  --       fsharp = '// %s',
  --       fsharp_project = '<!-- %s -->',
  --       gleam = '// %s',
  --       glimmer = '{{! %s }}',
  --       graphql = '# %s',
  --       handlebars = '{{! %s }}',
  --       hcl = '# %s',
  --       html = '<!-- %s -->',
  --       hyprlang = '# %s',
  --       ini = '; %s',
  --       ipynb = '# %s',
  --       javascript = {
  --         '// %s',                   -- default commentstring when no treesitter node matches
  --         '/* %s */',
  --         call_expression = '// %s', -- specific commentstring for call_expression
  --         jsx_attribute = '// %s',
  --         jsx_element = '{/* %s */}',
  --         jsx_fragment = '{/* %s */}',
  --         spread_element = '// %s',
  --         statement_block = '// %s',
  --       },
  --       kdl = '// %s',
  --       php = '// %s',
  --       rego = '# %s',
  --       rescript = '// %s',
  --       rust = { '// %s', '/* %s */' },
  --       sql = '-- %s',
  --       styled = '/* %s */',
  --       svelte = '<!-- %s -->',
  --       templ = {
  --         '// %s',
  --         component_block = '<!-- %s -->',
  --       },
  --       terraform = '# %s',
  --       tsx = {
  --         '// %s',                   -- default commentstring when no treesitter node matches
  --         '/* %s */',
  --         call_expression = '// %s', -- specific commentstring for call_expression
  --         jsx_attribute = '// %s',
  --         jsx_element = '{/* %s */}',
  --         jsx_fragment = '{/* %s */}',
  --         spread_element = '// %s',
  --         statement_block = '// %s',
  --       },
  --       twig = '{# %s #}',
  --       typescript = { '// %s', '/* %s */' }, -- langs can have multiple commentstrings
  --       vue = '<!-- %s -->',
  --       xaml = '<!-- %s -->',
  --     },
  --   },
  -- },

  -- Ts context comment
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    event = 'VeryLazy',
    opts = {
      -- enable_autocmd = false,
    },
  },

  -- Better managment
  {
    'ThePrimeagen/vim-be-good',
    cmd = 'VimBeGood',
  },
}
