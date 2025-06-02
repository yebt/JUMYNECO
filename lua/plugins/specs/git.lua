return {

  --- DIFF
  -- Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
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
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        -- map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        -- map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        -- map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        -- map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        -- map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        -- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        --
      end,
    }
  },

  -- DIFF
  -- {
  --   'echasnovski/mini.diff',
  --   version = false,
  --   lazy = false,
  --   opts ={
  --     -- Options for how hunks are visualized
  --     view = {
  --       -- Visualization style. Possible values are 'sign' and 'number'.
  --       -- Default: 'number' if line numbers are enabled, 'sign' otherwise.
  --       -- style = vim.go.number and 'number' or 'sign',
  --       style = 'sign',
  --
  --       -- Signs used for hunks with 'sign' view
  --       -- signs = { add = '▒', change = '▒', delete = '▒' },
  --       -- signs = { add = '+', change = '~', delete = '_' },
  --       signs = { add = '+', change = '~', delete = '' },
  --
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
  --       apply = 'gh',
  --
  --       -- Reset hunks inside a visual/operator region
  --       reset = 'gH',
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
  --       -- `'myers'|'minimal'|'patience'|'histogram'`,
  --       algorithm = 'histogram',
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

}
