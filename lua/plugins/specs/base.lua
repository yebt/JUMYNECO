--- Base plugins to work

return {
  {
    "folke/lazy.nvim",
    version = false
  },

  ---  QoL varius plugins
  {
    'folke/snacks.nvim',
    -- priority = 1000,
    -- lazy = false,
    event = {"VeryLazy"},
    dependencies = {
      { 'echasnovski/mini.icons', version = false },
    },
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        formats = {
          key = function(item)
            return { { '[', hl = 'special' }, { item.key, hl = 'key' }, { ']', hl = 'special' } }
          end,
        },
        preset = {
          header =table.concat( {
            "yebt",
          },"\n")
        },
        sections = {
          { section = 'startup' },
          -- { section = "terminal", cmd = "fortune -s | cowsay", hl = "header", padding = 1, indent = 8 },
          { title = 'MRU', padding = 1 },
          { section = 'recent_files', limit = 5, padding = 1 },
          { title = 'MRU ', file = vim.fn.fnamemodify('.', ':~'), padding = 1 },
          { section = 'recent_files', cwd = true, limit = 5, padding = 1 },
          { title = 'Sessions', padding = 1 },
          { section = 'projects', padding = 1 },
          { title = 'Bookmarks', padding = 1 },
          { section = 'keys' },
          { section = 'header'},
        },
      },
      explorer = {},
      image = { enabled = false },
      indent = {
        indent = {
          -- char = "│",
          -- ╎ │ ▏
          char = '▏',
        },
        animate = {
          enabled = false,
        },
        scope = {
          enabled = false,
          underline = true,
          only_current = true,
          char = '▏',
          -- char = "╎",
        },
        chunk = {
          enabled = true,
          only_current = true,
          char = {
            corner_top = '┌',
            corner_bottom = '└',
            -- corner_top = "╭",
            -- corner_bottom = "╰",
            horizontal = '─',
            vertical = '│',
            arrow = '>',
          },
        },
      },
      input = {
        enabled = true,
      },
      notifier = {
        --- "compact"|"fancy"|"minimal"
        style = 'compact',
      },
      picker = {
        prompt = ' ',
        matcher = {
          fuzzy = true, -- use fuzzy matching
          smartcase = true, -- use smartcase
          ignorecase = true, -- use ignorecase
          sort_empty = false, -- sort results when the search string is empty
          filename_bonus = true, -- give bonus for matching file names (last part of the path)
          file_pos = true, -- support patterns like `file:line:col` and `file:line`
          -- the bonusses below, possibly require string concatenation and path normalization,
          -- so this can have a performance impact for large lists and increase memory usage
          cwd_bonus = false, -- give bonus for matching files in the cwd
          frecency = true, -- frecency bonus
          history_bonus = false, -- give more weight to chronological order
        },
        -- formatters = {
        --   text = {
        --     ft = nil, ---@type string? filetype for highlighting
        --   },
        --   file = {
        --     filename_first = true, -- display filename before the file path
        --     truncate = 40, -- truncate the file path to (roughly) this length
        --     filename_only = false, -- only show the filename
        --     icon_width = 2, -- width of the icon (in characters)
        --     git_status_hl = true, -- use the git status highlight group for the filename
        --   },
        --   selected = {
        --     show_always = false, -- only show the selected column when there are multiple selections
        --     unselected = true, -- use the unselected icon for unselected items
        --   },
        --   severity = {
        --     icons = true, -- show severity icons
        --     level = false, -- show severity level
        --     ---@type "left"|"right"
        --     pos = "left", -- position of the diagnostics
        --   },
        -- },

        -- layouts = {
        --   files = {
        --     layout = {
        --       backdrop = false,
        --       row = 1,
        --       width = 0.4,
        --       min_width = 80,
        --       height = 0.8,
        --       border = "none",
        --       box = "vertical",
        --       { win = "preview", title = "{preview}", height = 0.4, border = "rounded" },
        --       {
        --         box = "vertical",
        --         border = "rounded",
        --         title = "{title} {live} {flags}",
        --         title_pos = "center",
        --         { win = "input", height = 1, border = "bottom" },
        --         { win = "list", border = "none" },
        --       },
        --     },
        --   }
        -- },
        -- win = {
        --   -- input window
        --   input = {
        --     keys = {
        --     },
        --   }
        -- },
      },
    },
    init = function()
      --- Disabled animations
      vim.g.snacks_animate = false
      ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
      local progress = vim.defaulttable()
      vim.api.nvim_create_autocmd('LspProgress', {
        ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
          if not client or type(value) ~= 'table' then
            return
          end
          local p = progress[client.id]

          for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
              p[i] = {
                token = ev.data.params.token,
                msg = ('[%3d%%] %s%s'):format(
                  value.kind == 'end' and 100 or value.percentage or 100,
                  value.title or '',
                  value.message and (' **%s**'):format(value.message) or ''
                ),
                done = value.kind == 'end',
              }
              break
            end
          end

          local msg = {} ---@type string[]
          progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
          end, p)

          local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
          vim.notify(table.concat(msg, '\n'), 'info', {
            id = 'lsp_progress',
            title = client.name,
            opts = function(notif)
              notif.icon = #progress[client.id] == 0 and ' '
                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
          })
        end,
      })
    end,
    -- config = function(_,opts)
    --   require("snacks").setup(opts)
    -- end,
    keys = {
      --- Buffers
      {
        '<M-c>',
        function()
          Snacks.bufdelete()
        end,
        desc = 'Delete a buffer',
      },
      {
        '<C-k><C-w>',
        function()
          Snacks.bufdelete.all()
        end,
        desc = 'Delete all buffers',
      },
      {
        '<C-k><C-q>',
        function()
          Snacks.bufdelete.other()
        end,
        desc = 'Delete all buffers but not the actual',
      },
      --- If use explorer
      {
        '<M-b>',
        function()
          Snacks.explorer()
        end,
        desc = 'Open snak explorer',
      },
      {
        '<leader>gsb',
        function()
          Snacks.git.blame_line()
        end,
        desc = 'Snak Git Blame Line',
      },
    },
  },


  ---
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
  },

  {
    "folke/flash.nvim",
    event ={'VeryLazy'},
    specs = {
     {
        "folke/snacks.nvim",
        opts = {
          picker = {
            win = {
              input = {
                keys = {
                  ["<M-s>"] = { "flash", mode = { "n", "i" } },
                  ["s"] = { "flash" },
                },
              },
            },
            actions = {
              flash = function(picker)
                vim.print('-----')
                require("flash").jump({
                  pattern = "^",
                  label = { after = { 0, 0 } },
                  search = {
                    mode = "search",
                    exclude = {
                      function(win)
                        return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                      end,
                    },
                  },
                  action = function(match)
                    local idx = picker.list:row2idx(match.pos[1])
                    picker.list:_move(idx, true, true)
                  end,
                })
              end,
            },
          },
        },
      },
    },
  },
}
