local custom_icons = require('modules.icons')
-- local
return function()
  local blinkcmp = require('blink.cmp')

  local opts = {
    completion = {
      --
      keyword = { range = 'prefix' },
      trigger = {
        prefetch_on_insert = true,
        show_in_snippet = true,
        show_on_keyword = true,
        show_on_trigger_character = true,
        show_on_accept_on_trigger_character = true,
        show_on_insert_on_trigger_character = true,
        show_on_x_blocked_trigger_characters = {
          "'", '"', '(', '{', '['
        }
      },
      list = {
        max_items = 200,
        selection = {
          preselect = true,
          auto_insert = false,
        }
      },
      accept = {
        dot_repeat = true,
        create_undo_point = true,
        auto_brackets = {
          enabled = true,
          default_brackets = { '(', ')' },
          override_brackets_for_filetypes = {},
          kind_resolution = {
            enabled = true,
            blocked_filetypes = { 'typescriptreact', 'javascriptreact', 'vue' },
          },
          semantic_token_resolution = {
            enabled = true,
            blocked_filetypes = { 'java' },
            timeout_ms = 400,
          },
        }
      },
      menu = {
        enabled = true,
        min_width = 15,
        max_height = 10,
        border = 'shadow',
        -- winblend = 10,
        winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
        scrolloff = 2,
        scrollbar = true,
        direction_priority = { 's', 'n' },
        auto_show = true,
        draw = {
          align_to = 'label',
          padding = 1,
          gap = 1,
          treesitter = { 'lsp' },
          columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'kind' }, { 'source_name' } },
          components = {
            kind_icon_gap = {
              ellipsis = false,
              text = function(ctx) return " " .. ctx.kind_icon .. ctx.icon_gap .. " " end,
              -- Set the highlight priority to 20000 to beat the cursorline's default priority of 10000
              highlight = function(ctx) return { { group = ctx.kind_hl, priority = 20000 } } end,
            },
          }
        }
      },
      documentation = {
        auto_show = true,

        auto_show_delay_ms = 500,
        update_delay_ms = 50,
      },
      ghost_text = {
        enabled = true,
      }
    },

    keymap = {
      -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-space>'] = { 'show_and_insert', 'show_documentation', 'hide_documentation' },
      ['<C-y>'] = { 'select_and_accept' },

      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },

      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

      ['<Tab>'] = { 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },

      ['<C-e>'] = { 'hide', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },

      ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },

    snippets = {
      -- Function to use when expanding LSP provided snippets
      expand = function(snippet) vim.snippet.expand(snippet) end,
      -- Function to use when checking if a snippet is active
      active = function(filter) return vim.snippet.active(filter) end,
      -- Function to use when jumping between tab stops in a snippet, where direction can be negative or positive
      jump = function(direction) vim.snippet.jump(direction) end,
    },

    signature = {
      enabled = true,
      trigger = {
        enabled = true,
        show_on_keyword = false,

        blocked_trigger_characters = {},
        blocked_retrigger_characters = {},
        show_on_trigger_character = true,

        show_on_insert = true,
        show_on_insert_on_trigger_character = true,
      }
    },

    fuzzy = {
      implementation = 'prefer_rust_with_warning',
      use_frecency = true,
      use_proximity = true,
      use_unsafe_no_lock = false,
      sorts = {

        -- Deprioritize
        function(a, b)
          if (not a or not b)
              or (a.source_id == nil or b.source_id == nil)
              or (a.source_id == b.source_id)
          then
            return false
          end

          return b.source_id == 'ripgrep'
        end,

        -- (optionally) always prioritize exact matches
        -- 'exact',

        -- pass a function for custom behavior
        -- function(item_a, item_b)
        --   return item_a.score > item_b.score
        -- end,
        -- 'kind',

        'score',
        'sort_text',
      },
    },

    sources = {
      -- default = { 'lsp', 'path', 'snippets', 'buffer' },
      -- default = { 'lsp', 'path', 'snippets', 'buffer' },
      default = { 'lsp', 'path', 'snippets', 'buffer', 'ripgrep' },
      min_keyword_length = 0,
      providers = {

        buffer = {
          --   -- keep case of first char
          --   transform_items = function(a, items)
          --     local keyword = a.get_keyword()
          --     local correct, case
          --     if keyword:match('^%l') then
          --       correct = '^%u%l+$'
          --       case = string.lower
          --     elseif keyword:match('^%u') then
          --       correct = '^%l+$'
          --       case = string.upper
          --     else
          --       return items
          --     end
          --
          --     -- avoid duplicates from the corrections
          --     local seen = {}
          --     local out = {}
          --     for _, item in ipairs(items) do
          --       local raw = item.insertText
          --       if raw:match(correct) then
          --         local text = case(raw:sub(1, 1)) .. raw:sub(2)
          --         item.insertText = text
          --         item.label = text
          --       end
          --       if not seen[item.insertText] then
          --         seen[item.insertText] = true
          --         table.insert(out, item)
          --       end
          --     end
          --     return out
          --   end,
          --
          --   --
          --   -- get_bufnrs = vim.api.nvim_list_bufs,
          --
          -- opts = {
          --   get_bufnrs = function()
          --     return vim.tbl_filter(function(bufnr)
          --       return vim.bo[bufnr].buftype == ''
          --     end, vim.api.nvim_list_bufs())
          --   end
          -- }
        },

        -- lsp = { fallbacks = {} },

        ripgrep = {
          module = "blink-cmp-rg",
          name = "Ripgrep",
          -- score_offset = -4,
          -- options below are optional, these are the default values
          ---@type blink-cmp-rg.Options
          opts = {
            -- `min_keyword_length` only determines whether to show completion items in the menu,
            -- not whether to trigger a search. And we only has one chance to search.
            prefix_min_len = 3,
            get_command = function(context, prefix)
              return {
                "rg",
                "--no-config",
                "--json",
                "--word-regexp",
                "--ignore-case",
                "--",
                prefix .. "[\\w_-]+",
                vim.fs.root(0, ".git") or vim.fn.getcwd(),
              }
            end,
            get_prefix = function(context)
              return context.line:sub(1, context.cursor[2]):match("[%w_-]+$") or ""
            end,
          },
        }
      }
    },

    cmdline = {
      enabled = false,
    },

    appearance = {
      use_nvim_cmp_as_default = false,
      -- mono, normal
      nerd_font_variant = 'mono',
      kind_icons = custom_icons.kind.text_compact
    },


    -- -- snippets = {
    -- --   -- Function to use when expanding LSP provided snippets
    -- --   expand = function(snippet)
    -- --     vim.snippet.expand(snippet)
    -- --   end,
    -- --   -- Function to use when checking if a snippet is active
    -- --   active = function(filter)
    -- --     return vim.snippet.active(filter)
    -- --   end,
    -- --   -- Function to use when jumping between tab stops in a snippet, where direction can be negative or positive
    -- --   jump = function(direction)
    -- --     vim.snippet.jump(direction)
    -- --   end,
    -- -- },
    -- -- snippets = { preset = 'luasnip' },
    -- snippets = { preset = 'luasnip' },
    -- -- snippets = { preset = 'mini_snippets' },
    --
    -- -- -- enabled = function()
    -- -- --   return vim.fn.getcmdtype() ~= ':'
    -- -- -- end,
    -- --
    -- -- -- Disable cmdline
    -- cmdline = {
    --   enabled = false,
    -- },
    -- --
    -- completion = {
    --   --   -- 'prefix' will fuzzy match on the text before the cursor
    --   --   -- 'full' will fuzzy match on the text before _and_ after the cursor
    --   --   -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
    --   keyword = { range = 'full' },
    --   accept = {
    --     -- Write completions to the `.` register
    --     dot_repeat = true,
    --     auto_brackets = { enabled = true },
    --     create_undo_point = true,
    --   },
    --   list = {
    --     --     max_items = 200,
    --     selection = { preselect = true, auto_insert = false },
    --     --     cycle = {
    --     --       from_bottom = true,
    --     --       from_top = true,
    --     --     },
    --   },
    --   menu = {
    --     auto_show = true,
    --     --     -- nvim-cmp style menu
    --     draw = {
    --       align_to = 'label',
    --       padding = 1,
    --       gap = 2,
    --       --       -- treesitter = {},
    --       treesitter = { 'lsp' },
    --       columns = {
    --         -- { 'kind_icon' },
    --         { 'kind_icon_pad' },
    --         -- { 'kind_mini_icon' },
    --         -- { 'kink_dev_icon' },
    --         { 'label', 'label_description', gap = 1 },
    --         { 'kind' },
    --         -- -- { 'source_name' },
    --         -- { 'source_name_flex' },
    --       },
    --       components = {
    --         kind_icon_pad = {
    --           ellipsis = false,
    --           text = function(ctx)
    --             return ' ' .. ctx.kind_icon .. ' ' .. ctx.icon_gap
    --           end,
    --           highlight = function(ctx)
    --             return ctx.kind_hl
    --           end,
    --         },
    --
    --         --         item_idx = {
    --         --           text = function(ctx)
    --         --             return ctx.idx == 10 and '0' or ctx.idx >= 10 and ' ' or tostring(ctx.idx)
    --         --           end,
    --         --           highlight = 'BlinkCmpItemIdx', -- optional, only if you want to change its color
    --         --         },
    --         --         kind_mini_icon = {
    --         --           ellipsis = false,
    --         --           text = function(ctx)
    --         --             local kind_icon = nil
    --         --             if usePath and vim.tbl_contains({ 'Path' }, ctx.source_name) then
    --         --               vim.notify(vim.inspect(ctx))
    --         --               kind_icon, _, _ = require('mini.icons').get('file', ctx.label)
    --         --             else
    --         --               kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
    --         --             end
    --         --             return kind_icon
    --         --           end,
    --         --           -- Optionally, you may also use the highlights from mini.icons
    --         --           highlight = function(ctx)
    --         --             local hl = nil
    --         --             if usePath and vim.tbl_contains({ 'Path' }, ctx.source_name) then
    --         --               _, hl, _ = require('mini.icons').get('file', ctx.label)
    --         --             else
    --         --               _, hl, _ = require('mini.icons').get('lsp', ctx.label)
    --         --             end
    --         --             -- local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
    --         --             return hl
    --         --           end,
    --         --         },
    --         --         kink_dev_icon = {
    --         --           text = function(ctx)
    --         --             local kIcon = nil
    --         --             if ctx.source_name:lower() == 'path' then
    --         --               kIcon = ' '
    --         --               local icon, hl_group = require('nvim-web-devicons').get_icon(ctx.label)
    --         --               if icon then
    --         --                 kIcon = ' ' .. icon
    --         --               end
    --         --               -- kIcon = icon
    --         --             else
    --         --               kIcon = ctx.kind_icon
    --         --             end
    --         --             -- return " " .. ctx.kind_icon .. " " .. ctx.icon_gap
    --         --             return kIcon .. ctx.icon_gap
    --         --           end,
    --         --           highlight = function(ctx)
    --         --             local hlGroup = 'BlinkCmpKind' .. ctx.kind
    --         --             if ctx.source_name:lower() == 'path' then
    --         --               local icon, hl_group = require('nvim-web-devicons').get_icon(ctx.label)
    --         --               if hl_group then
    --         --                 hlGroup = hl_group
    --         --               end
    --         --             else
    --         --               hlGroup = require('blink.cmp.completion.windows.render.tailwind').get_hl(ctx)
    --         --                 or ('CmpItemKind' .. ctx.kind:sub(1, 1):upper() .. ctx.kind:sub(2))
    --         --             end
    --         --             return hlGroup
    --         --             -- return require('blink.cmp.completion.windows.render.tailwind').get_hl(ctx)
    --         --             --     or ('CmpItemKind' .. ctx.kind:sub(1, 1):upper() .. ctx.kind:sub(2))
    --         --             --     or 'BlinkCmpKind' .. ctx.kind
    --         --           end,
    --         --         },
    --         --         source_name = {
    --         --           width = { max = 30 },
    --         --           text = function(ctx)
    --         --             return ctx.source_name
    --         --           end,
    --         --           highlight = 'BlinkCmpSource',
    --         --         },
    --         -- source_name_flex = {
    --         --   -- width ={},
    --         --   text = function(ctx)
    --         --     return '[' .. ctx.source_name:sub(1, 2) .. ']'
    --         --   end,
    --         --   highlight = 'BlinkCmpSource',
    --         -- },
    --         --         label = {
    --         --           width = { fill = true, max = 60 },
    --         --           text = function(ctx)
    --         --             return ctx.label .. ctx.label_detail
    --         --           end,
    --         --           highlight = function(ctx)
    --         --             -- label and label details
    --         --             local highlights = {
    --         --               { 0, #ctx.label, group = ctx.deprecated and 'BlinkCmpLabelDeprecated' or 'BlinkCmpLabel' },
    --         --             }
    --         --             if ctx.label_detail then
    --         --               table.insert(
    --         --                 highlights,
    --         --                 { #ctx.label, #ctx.label + #ctx.label_detail, group = 'BlinkCmpLabelDetail' }
    --         --               )
    --         --             end
    --         --
    --         --             -- characters matched on the label by the fuzzy matcher
    --         --             for _, idx in ipairs(ctx.label_matched_indices) do
    --         --               table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
    --         --             end
    --         --
    --         --             return highlights
    --         --           end,
    --         --         },
    --         --         label_description = {
    --         --           width = { max = 30 },
    --         --           text = function(ctx)
    --         --             return ctx.label_description
    --         --           end,
    --         --           highlight = 'BlinkCmpLabelDescription',
    --         --         },
    --       },
    --     },
    --   },
    -- },
    -- sources = {
    --   -- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
    --   default = { 'lsp', 'path', 'snippets', 'buffer' },
    -- },
    -- --
    -- signature = { enabled = true },
    -- --
    -- appearance = {
    --   -- highlight_ns = vim.api.nvim_create_namespace('blink_cmp'),
    --   -- use_nvim_cmp_as_default = false,
    --   use_nvim_cmp_as_default = true,
    --   --   -- BlinkCmpLabelDescription
    --   --   -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    --   --   -- Adjusts spacing to ensure icons are aligned
    --   -- nerd_font_variant = 'normal',
    --   nerd_font_variant = 'mono',
    --   --   kind_icons = custom_icons.kind.v4,
    --   -- kind_icons = custom_icons.kind.default,
    --   kind_icons = custom_icons.kind.text_compact,
    -- },
  }
  blinkcmp.setup(opts)
end
