return {

  --- Buffers
  {
    'leath-dub/snipe.nvim',
    keys = {
      {
        'gb',
        function()
          require('snipe').open_buffer_menu()
        end,
        desc = 'Open Snipe buffer menu',
      },
    },
    opts = {
      ui = {
        max_width = -1, -- -1 means dynamic width
        -- Where to place the ui window
        -- Can be any of "topleft", "bottomleft", "topright", "bottomright", "center", "cursor" (sets under the current cursor pos)
        position = 'topleft',
      },
      hints = {
        -- Charaters to use for hints (NOTE: make sure they don't collide with the navigation keymaps)
        dictionary = 'sadflewcmpghio',
      },
      navigate = {
        -- When the list is too long it is split into pages
        -- `[next|prev]_page` options allow you to navigate
        -- this list
        next_page = 'J',
        prev_page = 'K',

        -- You can also just use normal navigation to go to the item you want
        -- this option just sets the keybind for selecting the item under the
        -- cursor
        under_cursor = '<cr>',

        -- In case you changed your mind, provide a keybind that lets you
        -- cancel the snipe and close the window.
        cancel_snipe = '<esc>',
      },
      -- Define the way buffers are sorted by default
      -- Can be any of "default" (sort buffers by their number) or "last" (sort buffers by last accessed)
      sort = 'last',
    },
  },

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
    config = require('plugins.configs.wichkey'),
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
    config = function(_, opts)
      require('indentmini').setup(opts)
      -- vim.cmd.highlight('IndentLine guifg=#123456')
      -- Current indent line highlight
      -- vim.cmd.highlight('IndentLineCurrent guifg=#123456')
      vim.cmd.highlight('link IndentLine IndentBlanklineChar')
      vim.cmd.highlight('link IndentLineCurrent IndentBlanklineContextChar')
    end,
  },

  --- TODO comments
  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    event = { 'LazyFile', 'VeryLazy' },
    opts = {
      signs = true, -- show icons in the signs column
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
        fg = 'NONE', -- The gui style to use for the fg highlight group.
        bg = 'BOLD', -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      -- highlighting of the line containing the todo comment
      -- * before: highlights before the keyword (typically comment characters)
      -- * keyword: highlights of the keyword
      -- * after: highlights after the keyword (todo text)
      highlight = {
        multiline = false, -- enable multine todo comments
        multiline_pattern = '^.', -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
        before = '', -- "fg" or "bg" or empty
        keyword = 'wide', -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = 'fg', -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- list of file types to exclude highlighting
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
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
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
            mf.open(vim.api.nvim_buf_get_name(0), true)
          end
        end,
        silent = true,
        desc = 'Toggle Mini Files try reveal',
      },
    },
    init = require('plugins.inits.minifilesc'),
    config = require('plugins.configs.minifilesc'),
  },

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
    cmd = { 'Rest' },
    init = require('plugins.inits.resti'),
  }
}
