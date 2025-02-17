local custom_icons = require('modules.icons')
-- config
local usePath = true

-- exaplmes
-- icons

return function()
  local blinkcmp = require('blink.cmp')

  local opts = {
    keymap = {
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
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
      expand = function(snippet)
        vim.snippet.expand(snippet)
      end,
      -- Function to use when checking if a snippet is active
      active = function(filter)
        return vim.snippet.active(filter)
      end,
      -- Function to use when jumping between tab stops in a snippet, where direction can be negative or positive
      jump = function(direction)
        vim.snippet.jump(direction)
      end,
    },
    -- enabled = function()
    --   return vim.fn.getcmdtype() ~= ':'
    -- end,

    -- Disable cmdline
    cmdline = {
      enabled = false,
    },

    completion = {
      -- 'prefix' will fuzzy match on the text before the cursor
      -- 'full' will fuzzy match on the text before _and_ after the cursor
      -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
      keyword = { range = 'prefix' },
      accept = {
        -- Write completions to the `.` register
        dot_repeat = true,
        auto_brackets = { enabled = true },
        create_undo_point = true,
      },
      list = {
        max_items = 200,
        selection = { preselect = false, auto_insert = true },
        cycle = {
          from_bottom = true,
          from_top = true,
        },
      },

      menu = {
        auto_show = true,
        -- nvim-cmp style menu
        draw = {
          align_to = 'label',
          padding = 1,
          gap = 1,
          -- treesitter = {},
          treesitter = { 'lsp' },
          columns = {
            -- { 'kind_icon' },
            -- { 'kind_mini_icon' },
            { 'kink_dev_icon' },
            { 'label', 'label_description', gap = 1 },
            { 'kind' },
            { 'source_name_flex' },
          },
          components = {
            item_idx = {
              text = function(ctx)
                return ctx.idx == 10 and '0' or ctx.idx >= 10 and ' ' or tostring(ctx.idx)
              end,
              highlight = 'BlinkCmpItemIdx', -- optional, only if you want to change its color
            },
            kind_mini_icon = {
              ellipsis = false,
              text = function(ctx)
                local kind_icon = nil
                if usePath and vim.tbl_contains({ 'Path' }, ctx.source_name) then
                  vim.notify(vim.inspect(ctx))
                  kind_icon, _, _ = require('mini.icons').get('file', ctx.label)
                else
                  kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                end
                return kind_icon
              end,
              -- Optionally, you may also use the highlights from mini.icons
              highlight = function(ctx)
                local hl = nil
                if usePath and vim.tbl_contains({ 'Path' }, ctx.source_name) then
                  _, hl, _ = require('mini.icons').get('file', ctx.label)
                else
                  _, hl, _ = require('mini.icons').get('lsp', ctx.label)
                end
                -- local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
            },
            kink_dev_icon = {
              text = function(ctx)
                local kIcon = nil
                if ctx.source_name:lower() == 'path' then
                  kIcon = ' '
                  local icon, hl_group = require('nvim-web-devicons').get_icon(ctx.label)
                  if icon then
                    kIcon = ' ' .. icon
                  end
                  -- kIcon = icon
                else
                  kIcon = ctx.kind_icon
                end
                -- return " " .. ctx.kind_icon .. " " .. ctx.icon_gap
                return kIcon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                local hlGroup = 'BlinkCmpKind' .. ctx.kind
                if ctx.source_name:lower() == 'path' then
                  local icon, hl_group = require('nvim-web-devicons').get_icon(ctx.label)
                  if hl_group then
                    hlGroup = hl_group
                  end
                else
                  hlGroup = require('blink.cmp.completion.windows.render.tailwind').get_hl(ctx)
                    or ('CmpItemKind' .. ctx.kind:sub(1, 1):upper() .. ctx.kind:sub(2))
                end
                return hlGroup
                -- return require('blink.cmp.completion.windows.render.tailwind').get_hl(ctx)
                --     or ('CmpItemKind' .. ctx.kind:sub(1, 1):upper() .. ctx.kind:sub(2))
                --     or 'BlinkCmpKind' .. ctx.kind
              end,
            },
            source_name = {
              width = { max = 30 },
              text = function(ctx)
                return ctx.source_name
              end,
              highlight = 'BlinkCmpSource',
            },
            source_name_flex = {
              -- width ={},
              text = function(ctx)
                return '[' .. ctx.source_name:sub(1, 2) .. ']'
              end,
              highlight = 'BlinkCmpSource',
            },
            label = {
              width = { fill = true, max = 60 },
              text = function(ctx)
                return ctx.label .. ctx.label_detail
              end,
              highlight = function(ctx)
                -- label and label details
                local highlights = {
                  { 0, #ctx.label, group = ctx.deprecated and 'BlinkCmpLabelDeprecated' or 'BlinkCmpLabel' },
                }
                if ctx.label_detail then
                  table.insert(
                    highlights,
                    { #ctx.label, #ctx.label + #ctx.label_detail, group = 'BlinkCmpLabelDetail' }
                  )
                end

                -- characters matched on the label by the fuzzy matcher
                for _, idx in ipairs(ctx.label_matched_indices) do
                  table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
                end

                return highlights
              end,
            },
            label_description = {
              width = { max = 30 },
              text = function(ctx)
                return ctx.label_description
              end,
              highlight = 'BlinkCmpLabelDescription',
            },
          },
        },
      },
    },
    sources = {
      -- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    signature = { enabled = true },

    appearance = {
      -- highlight_ns = vim.api.nvim_create_namespace('blink_cmp'),
      -- use_nvim_cmp_as_default = false,
      use_nvim_cmp_as_default = true,
      -- BlinkCmpLabelDescription
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'normal',
      kind_icons = custom_icons.kind.v4,
    },
  }
  blinkcmp.setup(opts)
end
