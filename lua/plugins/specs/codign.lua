--- This plugins are needed to coding
return {

 --- Automatically add closing tags for HTML and JSX
  {
    'windwp/nvim-ts-autotag',
    event = 'LazyFile',
    -- event = 'VeryLazy',
    opts = {
      opts = {
        -- Defaults
        enable_close = true,          -- Auto close tags
        enable_rename = true,         -- Auto rename pairs of tags
        enable_close_on_slash = true, -- Auto close on trailing </
      },
      -- Also override individual filetype configs, these take priority.
      -- Empty by default, useful if one of the "opts" global settings
      -- doesn't work well in a specific filetype
      -- per_filetype = {
      --   ['html'] = {
      --     enable_close = false,
      --   },
      -- },
    },
  },

  --- Autopairs
  {
    'saghen/blink.pairs',
    -- build = 'cargo build --release', -- build from source
    -- NOTE:sometimes need nightly version, remember install nightly: `rustup install nightly`
    build = 'cargo +nightly build --release',
    event = { 'InsertEnter', 'User PostVeryLazy' },
    config = function()
      local blnkp = require('blink.pairs')

      local function makePair(pairStr)
        return {
          pairStr, space = true, enter = true
        }
      end

      -- @module 'blink.pairs'
      -- @type blink.pairs.Config
      local opts = {
        mappings = {
          -- you can call require("blink.pairs.mappings").enable() and require("blink.pairs.mappings").disable() to enable/disable mappings at runtime
          enabled = true,
          -- see the defaults: https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L10
          pairs = {
            ['!'] = { { '<!--', '-->', filetypes = { 'html', 'markdown' } } },
            ['('] =  makePair(')'),
            ['['] = makePair(']'),
            ['{'] = makePair('}'),
          },
        },
        highlights = {
          enabled = true,
          groups = {
            'BlinkPairsOrange',
            'BlinkPairsPurple',
            'BlinkPairsBlue',
          },
          matchparen = {
            enabled = true,
            group = 'MatchParen',
          },
        },
        debug = false,
      }

      blnkp.setup(opts)
    end
  },

  --- Context comment string but with configs
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
    opts = {
      lang = {
        astro = "<!-- %s -->",
        axaml = "<!-- %s -->",
        blueprint = "// %s",
        c = "// %s",
        c_sharp = "// %s",
        clojure = { ";; %s", "; %s" },
        cpp = "// %s",
        cs_project = "<!-- %s -->",
        cue = "// %s",
        fsharp = "// %s",
        fsharp_project = "<!-- %s -->",
        gleam = "// %s",
        glimmer = "{{! %s }}",
        graphql = "# %s",
        handlebars = "{{! %s }}",
        hcl = "# %s",
        html = "<!-- %s -->",
        hyprlang = "# %s",
        ini = "; %s",
        ipynb = "# %s",
        javascript = {
          "// %s", -- default commentstring when no treesitter node matches
          "/* %s */",
          call_expression = "// %s", -- specific commentstring for call_expression
          jsx_attribute = "// %s",
          jsx_element = "{/* %s */}",
          jsx_fragment = "{/* %s */}",
          spread_element = "// %s",
          statement_block = "// %s",
        },
        kdl = "// %s",
        php = "// %s",
        rego = "# %s",
        rescript = "// %s",
        rust = { "// %s", "/* %s */" },
        sql = "-- %s",
        styled = "/* %s */",
        svelte = "<!-- %s -->",
        templ = {
          "// %s",
          component_block = "<!-- %s -->",
        },
        terraform = "# %s",
        tsx = {
          "// %s", -- default commentstring when no treesitter node matches
          "/* %s */",
          call_expression = "// %s", -- specific commentstring for call_expression
          jsx_attribute = "// %s",
          jsx_element = "{/* %s */}",
          jsx_fragment = "{/* %s */}",
          spread_element = "// %s",
          statement_block = "// %s",
        },
        twig = "{# %s #}",
        typescript = { "// %s", "/* %s */" }, -- langs can have multiple commentstrings
        vue = "<!-- %s -->",
        xaml = "<!-- %s -->",
      },
    }
  },
}
