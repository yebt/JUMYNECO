--- Plugins to change the behaviour

return {
  --- QOL
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    -- event = {"VeryLazy"},
    dependencies = {
      { 'echasnovski/mini.icons', version = false },
      {
        'folke/which-key.nvim',
        opts = {
          spec = {
            {
              {
                mode = { 'n' },
                { '<leader>p', group = 'Pick Snacks', icon = '' },
                { '<leader>gp', group = 'Git Snacks', icon = '' },
              },
            },
          },
        },
      },
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
          header = table.concat({
            'yebt',
          }, '\n'),
          keys = {
            { icon = "󰸧", key = "l", desc = "Load last session", action = ":lua require('persistence').load({last=true})", },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
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
          { section = 'header' },
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
        --
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
        win = {
          -- input window
          input = {
            keys = {
              ['<M-p>'] = { 'toggle_preview', mode = { 'i', 'n' } },
            },
          },
        },
      },
      quickfile = {
        exclude = { 'latex' },
      },
      -- scope asd= {},
      -- scroll = { enabled = false },
      statuscolumn = {
        left = { 'mark', 'sign' }, -- priority of signs on the left (high to low)
        right = { 'fold', 'git' }, -- priority of signs on the right (high to low)
        folds = {
          open = false, -- show open fold icons
          git_hl = false, -- use Git Signs hl for fold icons
        },
        git = {
          -- patterns to match Git signs
          patterns = { 'GitSign', 'MiniDiffSign' },
        },
        refresh = 50, -- refresh at most every 50ms
      },
      words = {},
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

      -- Top Picker
      -- =====================
      {'<leader><space>', function() Snacks.picker.smart() end, desc = "SP: Smart Find files" },
      -- Git Picks
      -- =====================
      -- stylua: ignore
      {'<leader>gpf', function() Snacks.picker.git_files() end, desc = "SP: Git files" },
      { "<leader>gpb", function() Snacks.picker.git_branches() end, desc = "SP: Git Branches" },
      { "<leader>gpl", function() Snacks.picker.git_log() end, desc = "SP: Git Log" },
      { "<leader>gpL", function() Snacks.picker.git_log_line() end, desc = "SP: Git Log Line" },
      { "<leader>gps", function() Snacks.picker.git_status() end, desc = "SP: Git Status" },
      { "<leader>gpS", function() Snacks.picker.git_stash() end, desc = "SP: Git Stash" },
      { "<leader>gpd", function() Snacks.picker.git_diff() end, desc = "SP: Git Diff (Hunks)" },
      { "<leader>gpF", function() Snacks.picker.git_log_file() end, desc = "SP: Git Log File" },
      { "<leader>gpB", function() Snacks.picker.blame_line() end, desc = "SP: Git Blame Line" },

      -- Pickers Usual
      -- =====================
      {'<leader>pf', function() Snacks.picker.files() end, desc = "SP: Fiels" },
      {'<leader>pp', function() Snacks.picker.projects() end, desc = "SP: Projects" },
      {'<leader>pb', function() Snacks.picker.buffers() end, desc = "SP: Buffers" },
      {'<leader>pg', function() Snacks.picker.grep() end, desc = "SP: Grep" },
      {'<leader>pr', function() Snacks.picker.recent() end, desc = "SP: Recent" },
      {'<leader>pR', function() Snacks.picker.resume() end, desc = "SP: Resume" },
      {'<leader>pn', function() Snacks.picker.notifications() end, desc = "SP: Notifications" },

      -- Pickers LSP
      -- =====================
      {'<leader>pld', function() Snacks.picker.diagnostics_buffer() end, desc = "SP: Diagnostic in buffer" },
      {'<leader>plD', function() Snacks.picker.diagnostics() end, desc = "SP: Diagnostics" },
      { "<leader>pld", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      { "<leader>plD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
      { "<leader>plr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      { "<leader>plI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "<leader>ply", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
      { "<leader>pls", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
      { "<m-o>", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
      { "<leader>plS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },

      -- =============================================
      --- Buffers
      -- =====================
      {'<M-c>', function() Snacks.bufdelete() end, desc = 'Delete a buffer',},
      {'<C-k><C-w>', function() Snacks.bufdelete.all() end, desc = 'Delete all buffers',},
      {'<C-k><C-q>', function() Snacks.bufdelete.other() end, desc = 'Delete all buffers but not the actual',},

      --- If use explorer
      -- =====================
      {'<M-b>', function() Snacks.explorer() end, desc = 'Open snak explorer',},

      --- Usual Pickers
      {
        '<C-p>',
        function()
          Snacks.picker.files({
            formatters = {
              file = {
                -- filename_first = true,
                git_status_hl = false,
              },
            },
            layout = {
              --- VSCODE
              preview = false,
              layout = {
                row = 1,
                width = 0.4,
                min_width = 80,
                -- min_height=0.4,
                height = 0.4,
                border = 'none',
                box = 'vertical',
                -- border = "single",
                {
                  win = 'input',
                  height = 1,
                  border = 'bottom',
                  title = '{title} {live} {flags}',
                  title_pos = 'center',
                },
                { win = 'list', border = 'hpad' },
                { win = 'preview', title = '{preview}', border = 'rounded' },
              },
            },
          })
        end,
        desc = 'Pick Resume',
      },
      {
        '<c-l>',
        function()
          Snacks.notifier.hide()
        end,
        desc = 'Snacks hide notifications',
      },
    },
  },

  --- which key
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts_extend = { 'spec' },
    opts = {
      preset = 'helix',
      -- delay = 10,
      spec = {
        -- {
        --   {
        --     mode={'n','x'},
        --     {'<leader>gh', group = "Gitsigns"}
        --   }
        -- }
      },
      triggers = {
        --- Default
        -- { "<auto>", mode = "nxso" },
        --- trigger on a builtin keymap
        { '<auto>', mode = 'nixsotc' },
        { 'a', mode = { 'n', 'v' } },
      },
      win = {
        wo = {
          winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
        },
      },
      -- expand = function()
      --   return true
      -- end
      expand = function(node)
        return not node.desc -- expand all nodes without a description
      end,
      icons = {
        -- colors = false,
        rules = false,
      },
      -- loop = true
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
      {
        '<c-w><space>',
        function()
          require('which-key').show({ keys = '<c-w>', loop = true })
        end,
        desc = 'Window Hydra Mode (which-key)',
      },
    },
  },

  --- Good practices
  {
    'm4xshen/hardtime.nvim',
    lazy = false,
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {},
  },

  --- Motion
  {
    'folke/flash.nvim',
    -- event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      -- labels = "abcdefghijklmnopqrstuvwxyz",
      labels = 'asdfghjklqwertyuiopzxcvbnm',
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
    dependencies = {
      {
        'folke/which-key.nvim',
        opts = {
          spec = {
            {
              {
                mode = { 'n', 'x' },
                { '<leader>f', group = 'Flash', icon = '󰑮' },
              },
            },
          },
        },
      },
    },
    keys = {
      -- { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      {
        '<leader>fw',
        function()
          require('flash').jump({
            pattern = '.', -- initialize pattern with any char
            search = {
              mode = function(pattern)
                -- remove leading dot
                if pattern:sub(1, 1) == '.' then
                  pattern = pattern:sub(2)
                end
                -- return word pattern and proper skip pattern
                return ([[\<%s\w*\>]]):format(pattern), ([[\<%s]]):format(pattern)
              end,
            },
            -- select the range
            jump = { pos = 'range' },
          })
        end,
        desc = 'Flash match beginning of words only',
      },
      {
        '<leader>ff',
        function()
          local Flash = require('flash')

          ---@param opts Flash.Format
          local function format(opts)
            -- always show first and second label
            return {
              { opts.match.label1, 'FlashMatch' },
              { opts.match.label2, 'FlashLabel' },
            }
          end

          Flash.jump({
            search = { mode = 'search' },
            label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
            pattern = [[\<]],
            action = function(match, state)
              state:hide()
              Flash.jump({
                search = { max_length = 0 },
                highlight = { matches = false },
                label = { format = format },
                matcher = function(win)
                  -- limit matches to the current label
                  return vim.tbl_filter(function(m)
                    return m.label == match.label and m.win == win
                  end, state.results)
                end,
                labeler = function(matches)
                  for _, m in ipairs(matches) do
                    m.label = m.label2 -- use the second label
                  end
                end,
              })
            end,
            labeler = function(matches, state)
              local labels = state:labels()
              for m, match in ipairs(matches) do
                match.label1 = labels[math.floor((m - 1) / #labels) + 1]
                match.label2 = labels[(m - 1) % #labels + 1]
                match.label = match.label1
              end
            end,
          })
        end,
      },
      { 'f' },
      { 'F' },
      { 'T' },
      { 't' },
      { ',' },
      { ';' },
    },
  },

  --- Sessions
  {
    'folke/persistence.nvim',
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened
    opts = {
      -- add any custom options here
    },
    dependencies = {
      {
        'folke/which-key.nvim',
        opts = {
          spec = {
            {
              {
                mode = { 'n' },
                { '<leader>s', group = 'Sessions', icon = '󰆓' },
              },
            },
          },
        },
      },
    },
    keys = {
      {
        '<leader>ss',
        function()
          require('persistence').select()
        end,
        desc = 'Select session',
      },
      {
        '<leader>sl',
        function()
          require('persistence').load()
        end,
        desc = 'Select load',
      },
      {
        '<leader>sL',
        function()
          require('persistence').load({ last = true })
        end,
        desc = 'Select load last',
      },
    },
  },
}
