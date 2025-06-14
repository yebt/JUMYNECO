--- Plugings to coding
return {

  --- Autopairs
  {
    'saghen/blink.pairs',
    -- OR build from source
    build = 'cargo +nightly build --release',
    event = { 'VeryLazy', 'InsertEnter' },
    dependencies = {},
    --- @module 'blink.pairs'
    --- @type blink.pairs.Config
    opts = {
      mappings = {
        -- you can call require("blink.pairs.mappings").enable() and require("blink.pairs.mappings").disable() to enable/disable mappings at runtime
        enabled = true,
        -- see the defaults: https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L10
        pairs = {
          ['!'] = { { '<!--', '-->', filetypes = { 'html', 'markdown' } } },
          ['('] = { ')', space = true, enter = true },
          ['['] = { ']', space = true, enter = true },
          ['{'] = { '}', space = true, enter = true },
          ['*'] = { {
            '*',
            ' */',
            when = function()
              local cursor = vim.api.nvim_win_get_cursor(0)
              local line = vim.api.nvim_get_current_line()
              return line:sub(cursor[2] - 1, cursor[2]) == '/*'
            end,
            enter = true,
            space = false,
            backspace = false,
            filetypes = { 'php', 'phtml' }
          } },
        },
      },
      highlights = {
        enabled = true,
        groups = {
          'BlinkPairsOrange',
          'BlinkPairsPurple',
          'BlinkPairsBlue',
        },
        matchparen = {
          enabled = true,
          group = 'MatchParen',
        },
      },
      debug = false,
    },
  },


  --- File sistem iteration
  {
    'echasnovski/mini.files',
    version = false,
    dependencies = { 'echasnovski/mini.icons' },
    config = require('plugins.configs.mini-files-c'),
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
            MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
          end
        end,
        silent = true,
        desc = 'Toggle Mini Files try reveal',
      },
    },
  },


  --- Completion
  -- {
  --   'saghen/blink.cmp',
  --   version = '1.*',
  --   -- Provee snippets VSCode-style (incluye PHPDoc)
  --   dependencies = { 'rafamadriz/friendly-snippets' },
  --   event = { 'VeryLazy', 'InsertEnter' },
  --   opts = {
  --     -- Habilita la fuente de snippets junto a LSP, path y buffer
  --     sources = {
  --       default = { 'lsp', 'path', 'snippets', 'buffer' },
  --     },
  --     -- Usa la configuración por defecto de snippets (vim.snippet)
  --     -- Para LuaSnip, ver ejemplo en turn9view0
  --   },
  -- },

  --- Completion
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
      'rafamadriz/friendly-snippets',
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
        dependencies = {
          'rafamadriz/friendly-snippets',
        },
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
          require('luasnip.loaders.from_vscode').lazy_load({ paths = { './snippets' } })
        end,
      },
    },
    build = 'cargo +nightly build --release',
    event = { 'VeryLazy', 'InsertEnter' },
    ---@type blink.cmp.Config
    opts = {
      -- Disable cmdline
      cmdline = { enabled = false },

      completion = {
        keyword = {
          --- full, prefix
          range = 'full',
        },
        accept = {
          dot_repeat = true,
          create_undo_point = true,
          auto_brackets = {
            enabled = true,
          },
        },
        trigger = {
          --   -- Shows after typing a keyword, typically an alphanumeric character, - or _
          -- show_on_keyword = true,
          --   -- Shows after typing a trigger character, defined by the sources
          show_on_trigger_character = true,
          --   show_on_blocked_trigger_characters = { ' ', '\n', '\t' },
          --   -- Shows after entering insert mode on top of a trigger character
          -- show_on_insert_on_trigger_character = true,
          --   show_on_x_blocked_trigger_characters = {
          --     "'",
          --     '"',
          --     '(',
          --     '{',
          --     '[',
          --   },
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
        },
        documentation = {
          -- auto_show = false
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        menu = {
          draw = {
            columns = {
              { 'kind_icon' },
              { 'label',            'label_description', gap = 1 },
              { 'kind' },
              { 'source_name_short' },
            },
            components = {

              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local is_path = vim.tbl_contains({ 'Path' }, ctx.source_name)
                  local resolve_type = (not is_path) and 'lsp' or (ctx.kind == 'File' and 'file' or 'directory')
                  local resolve_item = is_path and ctx.label or ctx.kind
                  local kind_icon, _, _ = require('mini.icons').get(resolve_type, resolve_item)
                  return kind_icon
                end,
                -- Set the highlight priority to 20000 to beat the cursorline's default priority of 10000
                highlight = function(ctx)
                  local is_path = vim.tbl_contains({ 'Path' }, ctx.source_name)
                  local resolve_type = (not is_path) and 'lsp' or (ctx.kind == 'File' and 'file' or 'directory')
                  local resolve_item = is_path and ctx.label or ctx.kind
                  local _, hl, _ = require('mini.icons').get(resolve_type, resolve_item)
                  return { { group = hl, priority = 20000 } }
                  -- return { { group = ctx.kind_hl, priority = 20000 } }
                end,
              },

              kind = {
                -- (optional) use highlights from mini.icons
                highlight = function(ctx)
                  local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                  return hl
                end,
              },
              -- kind_icon = {
              --   text = function(ctx)
              --     -- local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
              --     local is_path = vim.tbl_contains({ 'Path' }, ctx.source_name)
              --     local typeel = is_path and 'file' or 'lsp'
              --     local el = is_path and ctx.label or ctx.kind
              --     local kind_icon, _, _ = require('mini.icons').get(typeel, el)
              --     if is_path then
              --       vim.print(ctx)
              --     end
              --     return kind_icon
              --   end,
              --   -- (optional) use highlights from mini.icons
              --   highlight = function(ctx)
              --     -- local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
              --     local is_path = vim.tbl_contains({ 'Path' }, ctx.source_name)
              --     local typeel = is_path and 'file' or 'lsp'
              --     local el = is_path and ctx.label or ctx.kind
              --     local _, hl, _ = require('mini.icons').get(typeel, el)
              --     return hl
              --   end,
              -- },
              -- kind = {
              --   -- (optional) use highlights from mini.icons
              --   highlight = function(ctx)
              --     -- local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
              --     local is_path = vim.tbl_contains({ 'Path' }, ctx.source_name)
              --     local typeel = is_path and 'file' or 'lsp'
              --     local el = is_path and ctx.label or ctx.kind
              --     local _, hl, _ = require('mini.icons').get(typeel, el)
              --     return hl
              --   end,
              -- },
              source_name_short = {
                width = { max = 30 },
                text = function(ctx)
                  return '[' .. ctx.source_name:sub(1, 3) .. ']'
                end,
                highlight = 'Comment',
              },
            },
          },
        },
        ghost_text = {
          enabled = false,
          -- Show the ghost text when an item has been selected
          show_with_selection = true,
          -- Show the ghost text when no item has been selected, defaulting to the first item
          show_without_selection = false,
          -- Show the ghost text when the menu is open
          show_with_menu = true,
          -- Show the ghost text when the menu is closed
          show_without_menu = true,
        },
      },

      snippets = {
        -- preset = 'default' | 'luasnip' | 'mini_snippets',
        preset = 'luasnip',
      },

      keymap = {
        -- preset = 'enter',
        -- preset = 'default',

        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
        ['<C-y>'] = { 'select_and_accept' },
        ['<CR>'] = { 'accept', 'fallback' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-n>'] = { 'select_next', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        --- When writing prose, you may want significantly different behavior than typical LSP completions.
        providers = {
          buffer = {
            -- keep case of first char
            -- transform_items = function(a, items)
            --   local keyword = a.get_keyword()
            --   local correct, case
            --   if keyword:match('^%l') then
            --     correct = '^%u%l+$'
            --     case = string.lower
            --   elseif keyword:match('^%u') then
            --     correct = '^%l+$'
            --     case = string.upper
            --   else
            --     return items
            --   end
            --
            --   -- avoid duplicates from the corrections
            --   local seen = {}
            --   local out = {}
            --   for _, item in ipairs(items) do
            --     local raw = item.insertText
            --     if raw:match(correct) then
            --       local text = case(raw:sub(1, 1)) .. raw:sub(2)
            --       item.insertText = text
            --       item.label = text
            --     end
            --     if not seen[item.insertText] then
            --       seen[item.insertText] = true
            --       table.insert(out, item)
            --     end
            --   end
            --   return out
            -- end,

            opts = {
              get_bufnrs = function()
                return vim
                    .iter(vim.api.nvim_list_bufs())
                    :filter(function(buf)
                      return vim.api.nvim_buf_is_loaded(buf)
                    end)
                    :totable()
                -- return vim
                --   .iter(vim.api.nvim_list_wins())
                --   :map(function(win)
                --     return vim.api.nvim_win_get_buf(win)
                --   end)
                --   :filter(function(buf)
                --     return vim.bo[buf].buftype ~= 'nofile'
                --   end)
                --   :totable()
              end,
            },
          },
          lsp = {
            override = {
              -- get_trigger_characters = function(self)
              --   -- vim.print(self)
              --   return {'.'}
              -- end
              -- get_trigger_characters = function()
              --   local clients = vim.lsp.get_clients({ bufnr = 0 })
              --   local trigger_characters = {}
              --
              --   for _, client in pairs(clients) do
              --     local completion_provider = client.server_capabilities.completionProvider
              --     if completion_provider and completion_provider.triggerCharacters then
              --       for _, trigger_character in pairs(completion_provider.triggerCharacters) do
              --         table.insert(trigger_characters, trigger_character)
              --       end
              --     end
              --   end
              --
              --   -- vim.print(clients and clients[1].server_capabilities.completionProvider)
              --   return trigger_characters
              -- end,
            },
          },
        },
      },

      fuzzy = {
        implementation = 'prefer_rust_with_warning',
        use_frecency = true,
        sorts = {
          -- 'exact',
          -- default sorts
          'score',
          'sort_text',
          -- 'label',
          -- 'kind'
        },
      },

      -- Signature
      -- Experimental signature help support
      signature = {
        enabled = true,
        trigger = {
          -- Show the signature help automatically
          enabled = true,
          -- Show the signature help window after typing any of alphanumerics, `-` or `_`
          show_on_keyword = false,
          blocked_trigger_characters = {},
          blocked_retrigger_characters = {},
          -- Show the signature help window after typing a trigger character
          show_on_trigger_character = true,
          -- Show the signature help window when entering insert mode
          show_on_insert = false,
          -- Show the signature help window when the cursor comes after a trigger character when entering insert mode
          show_on_insert_on_trigger_character = true,
        },
        window = {
          min_width = 1,
          max_width = 100,
          max_height = 10,
          border = nil, -- Defaults to `vim.o.winborder` on nvim 0.11+ or 'padded' when not defined/<=0.10
          winblend = 0,
          winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
          scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
          -- Which directions to show the window,
          -- falling back to the next direction when there's not enough space,
          -- or another window is in the way
          direction_priority = { 'n', 's' },
          -- Disable if you run into performance issues
          treesitter_highlighting = true,
          show_documentation = true,
        },
      },
    },
    opts_extend = { 'sources.default' },
  },

  -- notify progress
  {
    "j-hui/fidget.nvim",
    event = { 'LspAttach', 'VeryLazy' },
    opts = {
      -- options
      progress = {
        ignore_done_already = false
      },
    },
  }

}
