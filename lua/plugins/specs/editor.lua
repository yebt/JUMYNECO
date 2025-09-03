--- Things to edtit better
return {
  --- Surround
  -- MINI
  {
    'echasnovski/mini.surround',
    version = false,
    opts = {
      -- Add custom surroundings to be used on top of builtin ones. For more
      -- information with examples, see `:h MiniSurround.config`.
      custom_surroundings = nil,

      -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
      highlight_duration = 500,

      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        add = '<C-s>', -- Add surrounding in Normal and Visual modes
        -- delete = 'sd', -- Delete surrounding
        -- find = 'sf', -- Find surrounding (to the right)
        -- find_left = 'sF', -- Find surrounding (to the left)
        -- highlight = 'sh', -- Highlight surrounding
        -- replace = 'sr', -- Replace surrounding
        -- update_n_lines = 'sn', -- Update `n_lines`
        --
        -- suffix_last = 'l', -- Suffix to search with "prev" method
        -- suffix_next = 'n', -- Suffix to search with "next" method
      },

      -- Number of lines within which surrounding is searched
      n_lines = 20,

      -- Whether to respect selection type:
      -- - Place surroundings on separate lines in linewise mode.
      -- - Place surroundings on each line in blockwise mode.
      respect_selection_type = false,

      -- How to search for surrounding (first inside current line, then inside
      -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
      -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
      -- see `:h MiniSurround.config`.
      search_method = 'cover',

      -- Whether to disable showing non-error feedback
      -- This also affects (purely informational) helper messages shown after
      -- idle time if user input is required.
      silent = false,
    },
    keys = {
      { '<C-s>', mode = { 'n', 'x' } },
    },
  },

  --- Split and Join
  {
    'echasnovski/mini.splitjoin',
    version = false,
    opts = {
      -- Module mappings. Use `''` (empty string) to disable one.
      -- Created for both Normal and Visual modes.
      mappings = {
        toggle = 'gS',
        split = '',
        join = '',
      },

      -- Detection options: where split/join should be done
      detect = {
        -- Array of Lua patterns to detect region with arguments.
        -- Default: { '%b()', '%b[]', '%b{}' }
        brackets = nil,

        -- String Lua pattern defining argument separator
        separator = ',',

        -- Array of Lua patterns for sub-regions to exclude separators from.
        -- Enables correct detection in presence of nested brackets and quotes.
        -- Default: { '%b()', '%b[]', '%b{}', '%b""', "%b''" }
        exclude_regions = nil,
      },

      -- Split options
      split = {
        hooks_pre = {},
        hooks_post = {},
      },

      -- Join options
      join = {
        hooks_pre = {},
        hooks_post = {},
      },
    },
    keys = {
      { 'gS' },
    },
  },

  {
    'Wansmer/treesj',
    -- keys = { '<space>m', '<space>j', '<space>s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
    opts = {
      use_default_keymaps = false,
    },
    keys = {

      {
        '<leader>m',
        function()
          require('treesj').toggle()
        end,
        desc = "Toggle tree split join"
      },
      {
        '<leader>M',
        function()
          require('treesj').toggle({ split = { recursive = true } })
        end,
        desc = "Toggle tree split join recursive"
      },
    }
    -- config = function()
    --   require('treesj').setup({ --[[ your config ]] })
    -- end,
  },


  --- TODO txt:
  -- complex
  {
    "phrmendes/todotxt.nvim",
    cmd = { "TodoTxt", "DoneTxt" },
    dependencies = {
      {
        'folke/which-key.nvim',
        opts = {
          spec = {
            {
              {
                mode = { 'n' },
                { '<leader>t', group = 'TODO.txt', icon = '' },
              },
            },
          },
        },
      },
    },
    opts = {
      todotxt = "/home/de-web/Documents/todos/todo.txt",
      donetxt = "/home/de-web/Documents/todos/done.txt",
    },
    keys = {
      { '<leader>tn',  function() require("todotxt").capture_todo() end,           desc = "todo.txt: New entry" },
      { '<leader>to',  function() require("todotxt").toggle_todotxt() end,         desc = "todo.txt: Open" },
      { '<leader>tc',  function() require("todotxt").cycle_priority() end,         desc = "todo.txt: Cycle priority" },
      { '<leader>tt',  function() require("todotxt").toggle_todo_state() end,      desc = "todo.txt: Toggle task state" },
      { '<leader>td',  function() require("todotxt").move_done_tasks() end,        desc = "todo.txt: Move to done.txt" },
      { '<leader>tsd', function() require("todotxt").sort_tasks_by_due_date() end, desc = "todo.txt: Sort By due:date" },
      { '<leader>tsP', function() require("todotxt").sort_tasks_by_priority() end, desc = "todo.txt: Sort By (priority)" },
      { '<leader>tsc', function() require("todotxt").sort_tasks_by_context() end,  desc = "todo.txt: Sort By @context" },
      { '<leader>tsp', function() require("todotxt").sort_tasks_by_project() end,  desc = "todo.txt: Sort By +project" },
      { '<leader>tss', function() require("todotxt").sort_tasks() end,             desc = "todo.txt: Sort By +Default" },
    }
  },

  -- Fold
  {
    "chrisgrieser/nvim-origami",
    -- event = "VeryLazy",
    opts = {
      useLspFoldsWithTreesitterFallback = true,
      pauseFoldsOnSearch = true,
      foldtext = {
        enabled = true,
        padding = 3,
        lineCount = {
          template = "%d lines", -- `%d` is replaced with the number of folded lines
          hlgroup = "Comment",
        },
        diagnosticsCount = false, -- uses hlgroups and icons from `vim.diagnostic.config().signs`
        gitsignsCount = false,    -- requires `gitsigns.nvim`
      },
      autoFold = {
        enabled = false,
        kinds = { "comment", "imports" }, ---@type lsp.FoldingRangeKind[]
      },
      foldKeymaps = {
        setup = true, -- modifies `h` and `l`
        hOnlyOpensOnFirstColumn = false,
      },
    }, -- needed even when using default config

    -- recommended: disable vim's auto-folding
    init = function()
      -- vim.opt.foldlevel = 99
      -- vim.opt.foldlevelstart = 99
    end
  },

  -- Cycle folds
  -- {
  --   'jghauser/fold-cycle.nvim',
  --   keys = {
  --     {'z'}
  --   }
  --   -- config = function()
  --   --   require('fold-cycle').setup()
  --   -- end
  -- }

}
