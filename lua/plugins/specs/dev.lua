--- Plugings to coding
return {

  --- Autopairs
  {
    'saghen/blink.pairs',
    -- OR build from source
    build = 'cargo +nightly build --release',
    event = { 'VeryLazy', 'InsertEnter' },
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

  --- Completion
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
      'rafamadriz/friendly-snippets',
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
          range = 'prefix',
        },
        accept = {
          dot_repeat = true,
          create_undo_point = true,
          auto_brackets = {
            enabled = true,
          },
        },
        -- trigger = {
        --   -- Shows after typing a keyword, typically an alphanumeric character, - or _
        --   show_on_keyword = true,
        --   -- Shows after typing a trigger character, defined by the sources
        --   show_on_trigger_character = true,
        --   show_on_blocked_trigger_characters = { ' ', '\n', '\t' },
        --   -- Shows after entering insert mode on top of a trigger character
        --   show_on_insert_on_trigger_character = true,
        --   show_on_x_blocked_trigger_characters = {
        --     "'",
        --     '"',
        --     '(',
        --     '{',
        --     '[',
        --   },
        -- },
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
              { 'label', 'label_description', gap = 1 },
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
        preset = 'default',
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
            transform_items = function(a, items)
              local keyword = a.get_keyword()
              local correct, case
              if keyword:match('^%l') then
                correct = '^%u%l+$'
                case = string.lower
              elseif keyword:match('^%u') then
                correct = '^%l+$'
                case = string.upper
              else
                return items
              end

              -- avoid duplicates from the corrections
              local seen = {}
              local out = {}
              for _, item in ipairs(items) do
                local raw = item.insertText
                if raw:match(correct) then
                  local text = case(raw:sub(1, 1)) .. raw:sub(2)
                  item.insertText = text
                  item.label = text
                end
                if not seen[item.insertText] then
                  seen[item.insertText] = true
                  table.insert(out, item)
                end
              end
              return out
            end,
          },
        },
      },

      fuzzy = {
        implementation = 'prefer_rust_with_warning',
        use_frecency = true,
        sorts = {
          'exact',
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
}
