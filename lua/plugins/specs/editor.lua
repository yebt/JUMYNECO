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
    config = require('plugins.configs.rendermarkdown'),
  },

  --- Keys
  {
    'folke/which-key.nvim',
    -- lazy = false,
    event = 'VeryLazy',
    -- keys = {
    --   {
    --     '<leader>?',
    --     function()
    --       require('which-key').show({ global = false })
    --     end,
    --     desc = 'Buffer Local Keymaps (which-key)',
    --   },
    -- },
    config = require('plugins.configs.whichc'),
  },

  --- Indent
  {
    'nvimdev/indentmini.nvim',
    event = { 'LazyFile' },
    opts = {
      -- char = "│",
      -- ╎ │ ▏
      char = '▏',
      exclude = { 'markdown' },
      minlevel = 1,
    },
    -- init = function()
    --   vim.api.nvim_create_autocmd('ColorScheme', {
    --     pattern = '*',
    --     callback = function()
    --       vim.api.nvim_set_hl(0, 'IndentLine', { fg = '#6C6460' })
    --       vim.api.nvim_set_hl(0, 'IndentLineCurrent', { fg = '#B07B4C' })
    --       -- vim.cmd.highlight('link IndentLine IndentBlanklineChar')
    --       -- vim.cmd.highlight('link IndentLineCurrent IndentBlanklineContextChar')
    --     end,
    --   })
    -- end,

    config = function(_, opts)
      require('indentmini').setup(opts)
      -- vim.api.nvim_set_hl(0, 'IndentLine', { fg = '#6C6460' })
      -- vim.api.nvim_set_hl(0, 'IndentLineCurrent', { fg = '#B07B4C' })
      -- vim.cmd.highlight('IndentLine guifg=#123456')
      -- Current indent line highlight
      -- vim.cmd.highlight('IndentLineCurrent guifg=#123456')
    end,
  },

  --- TODO comments
  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    event = { 'LazyFile', 'VeryLazy' },
    opts = {
      signs = true,      -- show icons in the signs column
      sign_priority = 8, -- sign priority
      -- keywords recognized as todo comments
      keywords = {
        FIX = {
          icon = ' ', -- icon used for the sign, and in search results
          color = 'error', -- can be a hex color, or a named color (see below)
          alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = ' ', color = 'info' },
        HACK = { icon = ' ', color = 'warning' },
        WARN = { icon = '󰀪 ', color = 'warning', alt = { 'WARNING', 'XXX' } },
        PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
        TEST = { icon = '󰙨 ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
      },
      gui_style = {
        fg = 'NONE',         -- The gui style to use for the fg highlight group.
        bg = 'BOLD',         -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      -- highlighting of the line containing the todo comment
      -- * before: highlights before the keyword (typically comment characters)
      -- * keyword: highlights of the keyword
      -- * after: highlights after the keyword (todo text)
      highlight = {
        multiline = false,               -- enable multine todo comments
        multiline_pattern = '^.',        -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10,          -- extra lines that will be re-evaluated when changing a line
        before = '',                     -- "fg" or "bg" or empty
        keyword = 'wide',                -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = 'fg',                    -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true,            -- uses treesitter to match keywords in comments only
        max_line_len = 400,              -- ignore lines longer than this
        exclude = {},                    -- list of file types to exclude highlighting
      },
      -- list of named colors where we try to extract the guifg from the
      -- list of highlight groups or use the hex color if hl not found as a fallback
      colors = {
        error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
        warning = { 'DiagnosticWarn', 'WarningMsg', '#FBBF24' },
        info = { 'DiagnosticInfo', '#2563EB' },
        hint = { 'DiagnosticHint', '#10B981' },
        default = { 'Identifier', '#7C3AED' },
        test = { 'Identifier', '#FF00FF' },
      },
      search = {
        command = 'rg',
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
      },
    },
    -- stylua: ignore
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>",                      desc = "Todo (Trouble)" },
    },
  },

  --- mini sessions
  {
    'echasnovski/mini.sessions',
    version = false,
    -- lazy = false,
    -- event = 'VeryLazy',
    init = function()
      -- Make autosave session
      vim.api.nvim_create_autocmd('VimLeavePre', {
        group = vim.api.nvim_create_augroup('_mini_session_persistence', { clear = true }),
        callback = function()
          -- try load mini sessions
          local ok, ms = pcall(require, 'mini.sessions')
          if not ok then
            return
          end

          --
          local buffers = vim.fn.getbufinfo({ buflisted = 1 })
          local cntrs = #buffers

          -- Filter empty buffers
          for _, buffer in ipairs(buffers) do
            if buffer.name == '' then
              cntrs = cntrs - 1
            end
          end

          --
          if cntrs ~= 0 then
            local cwd = vim.fn.getcwd()
            local basename = cwd:match('[^/]+$')
            local path = cwd:gsub('/', '%%')
            local session_name = basename .. ' (' .. path .. ')'
            local session_opts = { verbose = false }
            ms.write(session_name, session_opts)
            ms.write('latest', session_opts) -- save the latest work
          end
        end,
      })
    end,
    keys = {
      -- {
      --   "<leader>ST",
      --   function()
      --     vim.notify(vim.inspect(MiniSessions.detected))
      --   end,
      -- },
      {
        '<leader>SS',
        function()
          require('mini.sessions').select()
          -- MiniSessions.select()
        end,
        desc = 'Select a session',
      },
      {
        '<leader>SM',
        function()
          -- local session_name = ('%s%ssession'):format(vim.fn.stdpath('data'), '_')
          local cwd = vim.fn.getcwd()
          local basename = cwd:match('[^/]+$')
          local path = cwd:gsub('/', '%%')
          -- local session_name = vim.fn.getcwd():gsub(pattern, "%%")
          -- local session_name = basename .. " (" .. cwd .. ")"
          local session_name = basename .. ' (' .. path .. ')'
          -- vim.notify(vim.inspect(session_name))
          require('mini.sessions').write(session_name)
        end,
        desc = 'Make session',
      },
      {
        '<leader>SL',
        function()
          require('mini.sessions').read('latest')
        end,
        desc = "Read 'latest' session",
      },
    },

    config = require('plugins.configs.minisessions'),
  },

  --- Files
  {
    'echasnovski/mini.files',
    version = false,
    keys = {
      {
        '\\',
        function()
          local ok, mf = pcall(require, 'mini.files')
          if not ok then
            return
          end
          if not mf.close() then
            mf.open()
          end
        end,
        silent = true,
        desc = 'Toggle Mini Files',
      },
      {
        '¿',
        function()
          local ok, mf = pcall(require, 'mini.files')
          if not mf.close() then
            -- MiniFiles.open()
            -- mf.open(vim.api.nvim_buf_get_name(0), true)
            MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
          end
        end,
        silent = true,
        desc = 'Toggle Mini Files try reveal',
      },
    },
    init = require('plugins.inits.minifilesc'),
    config = require('plugins.configs.minifilesc'),
  },

  --- Files 2
  -- {
  --   'X3eRo0/dired.nvim',
  --   -- event = "VeryLazy",
  --   cmd = {
  --     'Dired',
  --     'DiredRename',
  --     'DiredDelete',
  --     'DiredMark',
  --     'DiredDeleteRange',
  --     'DiredDeleteMarked',
  --     'DiredMarkRange',
  --     'DiredGoBack',
  --     'DiredGoUp',
  --     'DiredCopy',
  --     'DiredCopyRange',
  --     'DiredCopyMarked',
  --     'DiredMove',
  --     'DiredMoveRange',
  --     'DiredMoveMarked',
  --     'DiredPaste',
  --     'DiredEnter',
  --     'DiredCreate',
  --     'DiredToggleHidden',
  --     'DiredToggleSortOrder',
  --     'DiredToggleColors',
  --     'DiredToggleIcons',
  --     'DiredToggleHideDetails',
  --     'DiredQuit',
  --   },
  --   dependencies = {
  --     'MunifTanjim/nui.nvim',
  --   },
  --   config = require('plugins.configs.dirednvimc'),
  -- },

  --- Aliner
  {
    'godlygeek/tabular',
    cmd = { 'Tabularize', 'Tab' },
  },

  --- highlight
  {
    'brenoprata10/nvim-highlight-colors',
    cmd = { 'HighlightColors' },
    config = require('plugins.configs.nhc'),
  },

  --- term
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {},
    cmd = {
      'ToggleTerm',
    },
  },

  --- neotest
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },

  --- Rest
  {
    'rest-nvim/rest.nvim',
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "http")
      end,
    },
    cmd = { 'Rest' },
    init = require('plugins.inits.resti'),
  },

  --- Resty
  -- {
  --   'lima1909/resty.nvim',
  --   dependencies = { 'nvim-lua/plenary.nvim' },
  --   cmd = { 'Resty' },
  -- },

  -- Comment managment
  -- {
  --   'echasnovski/mini.comment',
  --   version = false,
  --   config = require('plugins.configs.minicomment'),
  --   keys = {
  --     { 'gc', desc = "Comment mini.comment" },
  --   }
  -- },
  {
    'numToStr/Comment.nvim',
    config = require('plugins.configs.commentnvim'),
    event = 'VeryLazy',
  },

  --- Split join
  {
    'echasnovski/mini.splitjoin',
    version = false,
    config = require('plugins.configs.minisplitjoin'),
    keys = {
      { 'gS', desc = 'SplitJoin Toggle' },
    },
  },

  --- Surround
  -- {
  --   'kylechui/nvim-surround',
  --   version = '*', -- Use for stability; omit to use `main` branch for the latest features
  --   event = 'VeryLazy',
  --   config = function()
  --     require('nvim-surround').setup({
  --       -- Configuration here, or leave empty to use defaults
  --       aliases = {
  --         ['a'] = '>',
  --         ['b'] = ')',
  --         ['B'] = '}',
  --         ['r'] = ']',
  --         ['q'] = { '"', "'", '`' },
  --         ['s'] = { '}', ']', ')', '>', '"', "'", '`' },
  --       },
  --       highlight = {
  --         duration = 0,
  --       },
  --       move_cursor = 'begin',
  --       keymaps = {
  --         insert = '<C-g>s',
  --         insert_line = '<C-g>S',
  --         normal = 'ys',
  --         normal_cur = 'yss',
  --         normal_line = 'yS',
  --         normal_cur_line = 'ySS',
  --         visual = '<C-s>',
  --         visual_line = '<C-s>',
  --         delete = 'ds',
  --         change = 'cs',
  --         change_line = 'cS',
  --       },
  --     })
  --   end,
  -- },

  -- Mini surround
  {
    'echasnovski/mini.surround',
    version = '*',
    event = "VeryLazy",
    opts = {
      -- Add custom surroundings to be used on top of builtin ones. For more
      -- information with examples, see `:h MiniSurround.config`.
      custom_surroundings = nil,

      -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
      highlight_duration = 500,

      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        add = '<C-s>',       -- Add surrounding in Normal and Visual modes
        delete = '',         -- Delete surrounding
        find = '',           -- Find surrounding (to the right)
        find_left = '',      -- Find surrounding (to the left)
        highlight = '',      -- Highlight surrounding
        replace = '',        -- Replace surrounding
        update_n_lines = '', -- Update `n_lines`

        suffix_last = '',    -- Suffix to search with "prev" method
        suffix_next = '',    -- Suffix to search with "next" method
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
    }
  },

}
