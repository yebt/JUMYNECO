return {
  --- Boilerplate
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    dependencies = {
      { 'echasnovski/mini.icons', version = false },
    },
    opts = {
      bigfile = {enabled = true},
      dashboard = {
        formats = {
          key = function(item)
            return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
          end,
        },
        sections = {
          { section = "startup" },
          -- { section = "terminal", cmd = "fortune -s | cowsay", hl = "header", padding = 1, indent = 8 },
          { title = "MRU", padding = 1 },
          { section = "recent_files", limit = 5, padding = 1 },
          { title = "MRU ", file = vim.fn.fnamemodify(".", ":~"), padding = 1 },
          { section = "recent_files", cwd = true, limit = 5, padding = 1 },
          { title = "Sessions", padding = 1 },
          { section = "projects", padding = 1 },
          { title = "Bookmarks", padding = 1 },
          { section = "keys" },
        },
      },
      explorer = {},
      image ={ enabled = false},
      indent = {
        indent = {
          -- char = "│",
          -- ╎ │ ▏
          char = '▏',
        },
        animate = {
          enabled=false
        },
        scope = {
          enabled=false,
          underline = true,
          only_current = true,
          char = '▏',
          -- char = "╎",
        },
        chunk = {
          enabled = true,
          only_current = true,
          char = {
            corner_top = "┌",
            corner_bottom = "└",
            -- corner_top = "╭",
            -- corner_bottom = "╰",
            horizontal = "─",
            vertical = "│",
            arrow = ">",
          },
        },
      },
      input = {
        enabled = true
      },
      notifier = {
        --- "compact"|"fancy"|"minimal"
        style =  "compact",
      },
      picker = {
        prompt = " ",
      }
    },
    init = function()
      --- Disabled animations
      -- vim.g.snacks_animate = false
      ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
      local progress = vim.defaulttable()
      vim.api.nvim_create_autocmd("LspProgress", {
        ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
          if not client or type(value) ~= "table" then
            return
          end
          local p = progress[client.id]

          for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
              p[i] = {
                token = ev.data.params.token,
                msg = ("[%3d%%] %s%s"):format(
                  value.kind == "end" and 100 or value.percentage or 100,
                  value.title or "",
                  value.message and (" **%s**"):format(value.message) or ""
                ),
                done = value.kind == "end",
              }
              break
            end
          end

          local msg = {} ---@type string[]
          progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
          end, p)

          local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
          vim.notify(table.concat(msg, "\n"), "info", {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
              notif.icon = #progress[client.id] == 0 and " "
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
      {"<M-c>", function() Snacks.bufdelete() end, desc = "Delete a buffer"},
      {"<C-k><C-w>", function() Snacks.bufdelete.all() end, desc = "Delete all buffers"},
      {"<C-k><C-q>", function() Snacks.bufdelete.other() end, desc = "Delete all buffers but not the actual"},
      --- If use explorer
      {"<M-b>", function() Snacks.explorer() end, desc = "Open snak explorer"},
      {"<leader>gsb", function() Snacks.git.blame_line() end, desc = "Snak Git Blame Line"},
    }
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    optional = true,
    opts = {
      signs = true, -- show icons in the signs column
      sign_priority = 8, -- sign priority
      -- keywords recognized as todo comments
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
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    },
    keys = {
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
      { "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    },
  },

  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
  },
}

