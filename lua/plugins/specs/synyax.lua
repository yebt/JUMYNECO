-- All about syntax highlight

return {
  --- TODO comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = 'VeryLazy',
    opts = {
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = "󱐋 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "󰙨 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    },
    keys = {
      { '<leader>xt', '<cmd>Trouble todo toggle<cr>', desc = 'Todo (Trouble)' },
    }
  },

  --- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "LazyFile", "VeryLazy" },
    lazy = false,
    priority = 1000000,
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      matchup = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "vue",
        "css",
        "scss",
        "todotxt"
      },
      auto_install = true,
    },
    config = function(_, opts)
      require 'nvim-treesitter.configs'.setup(opts)
      vim.schedule(function()
        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      end)
    end
  },

  --- For comments
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = 'VeryLazy',
  },

  -- {
  --   "folke/ts-comments.nvim",
  --   opts = {},
  --   event = "VeryLazy",
  -- },

  --- Context
  {
    "nvim-treesitter/nvim-treesitter-context",
    -- event = 'VeryLazy',
    opts = {
      enable = false,           -- Enable this plugin (Can be enabled/disabled later via commands)
      multiwindow = false,      -- Enable multiwindow support.
      max_lines = 3,            -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 4,      -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    },
    cmd = { "TSContext" },
  },


  -- {
  --   "andymass/vim-matchup",
  --   event = "VeryLazy"
  -- },

  {
    "windwp/nvim-ts-autotag",
    -- event = "LazyFile",
    lazy = false,
    opts = {
      opts = {
        -- Defaults
        enable_close = true,         -- Auto close tags
        enable_rename = true,        -- Auto rename pairs of tags
        enable_close_on_slash = true -- Auto close on trailing </
      },
    },
  },

  {
    'andymass/vim-matchup',
    -- lazy = false,
    event = "LazyFile",
    init = function()
      -- modify your configuration vars here
      vim.g.matchup_treesitter_stopline = 500

      -- or call the setup function provided as a helper. It defines the
      -- configuration vars for you
      require('match-up').setup({
        treesitter = {
          stopline = 500
        }
      })
      vim.schedule(function()
        vim.api.nvim_set_hl(0, 'MatchParen', {
          italic = true,
          bold = true,
          underline = true,
          -- reverse = true,
          -- foreground = "None",
        })
      end)
      -- vim.cmd("hi! MatchParen  cterm=italic gui=italic,underline guifg=None underline")
    end,
    -- or use the `opts` mechanism built into `lazy.nvim`. It calls
    -- `require('match-up').setup` under the hood
    ---@type matchup.Config
    opts = {
      treesitter = {
        stopline = 500,
      }
    }
  },

  --- Makrdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    event = { "LazyFile" },
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = {
        blink = { enabled = true },
        lsp = { enabled = true },
      },
      preset = 'obsidian',
      -- preset = 'lazy',
      checkbox = {
        -- Checkboxes are a special instance of a 'list_item' that start with a 'shortcut_link'.
        -- There are two special states for unchecked & checked defined in the markdown grammar.

        -- Turn on / off checkbox state rendering.
        enabled = true,
        -- Additional modes to render checkboxes.
        render_modes = false,
        -- Render the bullet point before the checkbox.
        bullet = false,
        -- Padding to add to the right of checkboxes.
        right_pad = 1,
        unchecked = {
          -- Replaces '[ ]' of 'task_list_marker_unchecked'.
          icon = ' ',
          -- Highlight for the unchecked icon.
          highlight = 'RenderMarkdownUnchecked',
          -- Highlight for item associated with unchecked checkbox.
          scope_highlight = nil,
        },
        checked = {
          -- Replaces '[x]' of 'task_list_marker_checked'.
          icon = '󰄳 ',
          -- Highlight for the checked icon.
          highlight = 'RenderMarkdownChecked',
          -- Highlight for item associated with checked checkbox.
          scope_highlight = nil,
        },
        -- Define custom checkbox states, more involved, not part of the markdown grammar.
        -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks.
        -- The key is for healthcheck and to allow users to change its values, value type below.
        -- | raw             | matched against the raw text of a 'shortcut_link'           |
        -- | rendered        | replaces the 'raw' value when rendering                     |
        -- | highlight       | highlight for the 'rendered' icon                           |
        -- | scope_highlight | optional highlight for item associated with custom checkbox |
        -- stylua: ignore
        custom = {
          todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
          delegated = { raw = '[>]', rendered = '󰳠 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
          progress = { raw = '[.]', rendered = '󱎕 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
        },
      },
    },
  },
}
