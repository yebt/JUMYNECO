return function()
  require('mini.statusline').setup({
    -- Content of statusline as functions which return statusline string. See
    -- `:h statusline` and code of default contents (used instead of `nil`).
    content = {
      -- Content for active window
      active = function()
        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 999 })
        local git = MiniStatusline.section_git({ trunc_width = 40 })
        local diff = MiniStatusline.section_diff({ trunc_width = 75 })
        local diagnostics = MiniStatusline.section_diagnostics({
          trunc_width = 75,
          signs = { ERROR = '!', WARN = '?', INFO = '@', HINT = '*' },
        })
        local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
        -- local filename = MiniStatusline.section_filename({ trunc_width = 9999 })
        local filename = (function(args)
          -- In terminal always use plain name
          if vim.bo.buftype == 'terminal' then
            return '%t'
          end
          local fn = vim.fn.fnamemodify(vim.fn.expand('%'), ':p:~:.')
          return fn .. '%m%r'
        end)({ trunc_width = 60 })
        -- local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
        local fileinfo = (function(args)
          local filetype = vim.bo.filetype
          if filetype == '' then
            return ''
          end
          local rfltp = filetype
          local nwd = require('nvim-web-devicons').get_icon(filetype, nil, { default = true })
          if nwd ~= nil then
            rfltp = nwd .. ' ' .. filetype
          end
          if MiniStatusline.is_truncated(args.trunc_width) or vim.bo.buftype ~= '' then
            return nwd or filetype
          end
          return rfltp
        end)({ trunc_width = 120 })
        local location = MiniStatusline.section_location({ trunc_width = 75 })
        local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

        return MiniStatusline.combine_groups({
          { hl = mode_hl, strings = { mode } },
          { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
          '%<', -- Mark general truncate point
          { hl = 'MiniStatuslineFilename', strings = { filename } },
          '%=', -- End left alignment
          { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
          { hl = mode_hl, strings = { search, location } },
        })
      end,
      -- Content for inactive window(s)
      inactive = nil,
    },

    -- Whether to use icons by default
    use_icons = true,

    -- Whether to set Vim's settings for statusline (make it always shown)
    set_vim_settings = true,
  })
end
