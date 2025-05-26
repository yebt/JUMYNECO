--- This contain all integrations with GIT
return {
  --- Git Diff
  -- {
  --   'echasnovski/mini.diff', version = false ,
  --   -- event = {"LazyFile", "User PostVeryLazy"},
  --   lazy = false,
  --   -- init = function()
  --   --   vim.api.nvim_create_autocmd('ColorScheme',{
  --   --     callback = function()
  --   --       vim.api.nvim_set_hl(0, "",{})
  --   --     end,
  --   --     desc = "Ser colors for diff",
  --   --   })
  --   -- end,
  --   opts  ={
  --     -- Options for how hunks are visualized
  --     view = {
  --       -- Visualization style. Possible values are 'sign' and 'number'.
  --       -- Default: 'number' if line numbers are enabled, 'sign' otherwise.
  --       -- style = vim.go.number and 'number' or 'sign',
  --       style = 'sign',
  --
  --       -- Signs used for hunks with 'sign' view
  --       -- signs = { add = '▒', change = '▒', delete = '▒' },
  --       signs = { add = '+', change = '~', delete = '_' },
  --
  --       -- Priority of used visualization extmarks
  --       priority = 199,
  --     },
  --
  --     -- Source(s) for how reference text is computed/updated/etc
  --     -- Uses content from Git index by default
  --     source = nil,
  --
  --     -- Delays (in ms) defining asynchronous processes
  --     delay = {
  --       -- How much to wait before update following every text change
  --       text_change = 200,
  --     },
  --
  --     -- Module mappings. Use `''` (empty string) to disable one.
  --     mappings = {
  --       -- Apply hunks inside a visual/operator region
  --       -- apply = 'gh',
  --       apply = '',
  --
  --       -- Reset hunks inside a visual/operator region
  --       -- reset = 'gH',
  --       reset = '',
  --
  --       -- Hunk range textobject to be used inside operator
  --       -- Works also in Visual mode if mapping differs from apply and reset
  --       textobject = 'gh',
  --
  --       -- Go to hunk range in corresponding direction
  --       goto_first = '[H',
  --       goto_prev = '[h',
  --       goto_next = ']h',
  --       goto_last = ']H',
  --     },
  --
  --     -- Various options
  --     options = {
  --       -- Diff algorithm. See `:h vim.diff()`.
  --       -- {algorithm}? (`'myers'|'minimal'|'patience'|'histogram'`,
  --       algorithm = 'patience',
  --
  --       -- Whether to use "indent heuristic". See `:h vim.diff()`.
  --       indent_heuristic = true,
  --
  --       -- The amount of second-stage diff to align lines (in Neovim>=0.9)
  --       linematch = 60,
  --
  --       -- Whether to wrap around edges during hunk navigation
  --       wrap_goto = false,
  --     },
  --   }
  -- },

  --- Signs
  {
    "lewis6991/gitsigns.nvim",
    event = {"LazyFile","VeryLazy"},
    opts = {
      signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signs_staged = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signs_staged_enable = true,
      signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        follow_files = true
      },
      auto_attach = true,
      attach_to_untracked = false,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
      },
      current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
    },
    keys = {},
  },
}
