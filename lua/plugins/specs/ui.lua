return {
    --- GIT
    {
      "lewis6991/gitsigns.nvim",
      event ={"LazyFile","VeryLazy"},
      opts  = {
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
      }
    },

    --- Indent
    -- NOTE: remplazed by snackt
    -- {
    --     "nvimdev/indentmini.nvim",
    --     event = {"VeryLazy", "BufEnter"},
    --     opts ={},
    -- },

    --- Dashboard
    -- NOTE: remplazed by snackt
    -- {
    --     "echasnovski/mini.starter",
    --     dependencies = {'nvim-tree/nvim-web-devicons'};
    --     config = require('plugins.configs.mini-starter-c'),
    --     cond =function()
    --         return vim.fn.argc() == 0
    --         and vim.api.nvim_buf_line_count(0) == 0
    --         and vim.api.nvim_buf_get_name(0) == ''
    --     end,
    --     event = 'VimEnter',
    -- },


    -- Statusline

    --- ICONS
    -- {
    --     "nvim-tree/nvim-web-devicons",
    --     opts  = {
    --         override = {
    --             zsh = {
    --                 icon = "",
    --                 color = "#428850",
    --                 cterm_color = "65",
    --                 name = "Zsh"
    --             }
    --         },
    --         override_by_filename = {
    --             [".gitignore"] = {
    --                 icon = "",
    --                 color = "#f1502f",
    --                 name = "Gitignore"
    --             }
    --         };
    --         -- same as `override` but specifically for overrides by extension
    --         -- takes effect when `strict` is true
    --         override_by_extension = {
    --             ["log"] = {
    --                 icon = "",
    --                 color = "#81e043",
    --                 name = "Log"
    --             }
    --         };
    --         -- same as `override` but specifically for operating system
    --         -- takes effect when `strict` is true
    --         override_by_operating_system = {
    --             ["apple"] = {
    --                 icon = "",
    --                 color = "#A2AAAD",
    --                 cterm_color = "248",
    --                 name = "Apple",
    --             },
    --         };
    --     }
    -- }
}
