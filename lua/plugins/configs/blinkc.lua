-- config
local usePath = true

-- exaplmes
-- icons
local default_kind_icons = {
  Text = '󰉿',
  Method = '󰊕',
  Function = '󰊕',
  Constructor = '󰒓',

  Field = '󰜢',
  Variable = '󰆦',
  Property = '󰖷',

  Class = '󱡠',
  Interface = '󱡠',
  Struct = '󱡠',
  Module = '󰅩',

  Unit = '󰪚',
  Value = '󰦨',
  Enum = '󰦨',
  EnumMember = '󰦨',

  Keyword = '󰻾',
  Constant = '󰏿',

  Snippet = '󱄽',
  Color = '󰏘',
  File = '󰈔',
  Reference = '󰬲',
  Folder = '󰉋',
  Event = '󱐋',
  Operator = '󰪚',
  TypeParameter = '󰬛',
}

local v1_kind_icons = {
  Text = '',
  Method = '',
  Function = '󰡱',
  Constructor = '',

  Field = '',
  Variable = '󰫧',
  Property = '',

  Class = '',
  Interface = '',
  Struct = '',
  Module = '󰕳',

  Unit = '',
  Value = '󰎠',
  Enum = '',
  EnumMember = '',

  Keyword = '',
  Constant = '󰏿',

  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
}

local v2_kind_icons = {
  Text = '', --  (nf-fa-file_text)
  Method = '', --  (nf-mdi-function)
  Function = '', --  (nf-mdi-function)
  Constructor = '', --  (nf-mdi-hammer)

  Field = 'ﰠ', -- ﰠ (nf-mdi-variable)
  Variable = '', --  (nf-mdi-variable)
  Property = 'ﰠ', -- ﰠ (nf-mdi-variable)

  Class = 'ﴯ', -- ﴯ (nf-mdi-class)
  Interface = '', --  (nf-mdi-interface)
  Struct = 'פּ', -- פּ (nf-mdi-struct)
  Module = '', --  (nf-mdi-module)

  Unit = '塞', -- 塞 (nf-mdi-unit)
  Value = '', --  (nf-mdi-value)
  Enum = '', --  (nf-mdi-enum)
  EnumMember = '', --  (nf-mdi-enum)

  Keyword = '', --  (nf-mdi-keyword)
  Constant = '', --  (nf-mdi-constant)

  Snippet = '', --  (nf-mdi-snippet)
  Color = '', --  (nf-mdi-color)
  File = '', --  (nf-mdi-file)
  Reference = '', --  (nf-mdi-reference)
  Folder = '', --  (nf-mdi-folder)
  Event = '', --  (nf-mdi-event)
  Operator = '', --  (nf-mdi-operator)
  TypeParameter = '', --  (nf-mdi-type_parameter)
}

local v3_kind_icons = {
  Text = '󰉿', -- nf-md-text_box (texto)
  Method = '', -- nf-cod-symbol_method (método)
  Function = '󰊕', -- nf-md-function (función)
  Constructor = '', -- nf-cod-constructor (constructor)

  Field = '', -- nf-cod-symbol_field (campo)
  Variable = '', -- nf-dev-variable (variable)
  Property = '', -- nf-custom-property (propiedad)

  Class = '', -- nf-cod-symbol_class (clase)
  Interface = '', -- nf-cod-symbol_interface (interfaz)
  Struct = '', -- nf-cod-structure (estructura)
  Module = '󰕳', -- nf-md-application_export (módulo)

  Unit = '', -- nf-fa-cube (unidad)
  Value = '', -- nf-mdi-numeric (valor)
  Enum = '', -- nf-fa-list_alt (enumeración)
  EnumMember = '', -- nf-cod-symbol_enum_member (miembro de enum)

  Keyword = '', -- nf-mdi-keyword (palabra clave)
  Constant = '', -- nf-cod-symbol_constant (constante)

  Snippet = '', -- nf-mdi-code_array (snippet)
  Color = '', -- nf-fa-paint_brush (color)
  File = '', -- nf-fa-file (archivo)
  Reference = '', -- nf-fa-reply (referencia)
  Folder = '', -- nf-fa-folder (carpeta)
  Event = '', -- nf-cod-symbol_event (evento)
  Operator = '➕', -- nf-fa-plus (operador)
  TypeParameter = '', -- nf-cod-type_parameter (parámetro de tipo)
}

local v4_kink_icons = {
  Array = '  ',
  Boolean = ' 󰨙 ',
  Class = ' 󰯳 ',
  Codeium = ' 󰘦 ',
  Color = '  ',
  Control = '  ',
  Collapsed = ' > ',
  Constant = ' 󰯱 ',
  Constructor = '  ',
  Copilot = '  ',
  Enum = ' 󰯹 ',
  EnumMember = '  ',
  Event = '  ',
  Field = '  ',
  File = '  ',
  Folder = '  ',
  Function = ' 󰡱 ',
  Interface = ' 󰰅 ',
  Key = '  ',
  Keyword = ' 󱕴 ',
  Method = ' 󰰑 ',
  Module = ' 󰆼 ',
  Namespace = ' 󰰔 ',
  Null = '  ',
  Number = ' 󰰔 ',
  Object = ' 󰲟 ',
  Operator = '  ',
  Package = ' 󰰚 ',
  Property = ' 󰲽 ',
  Reference = ' 󰰠 ',
  Snippet = '  ',
  String = '  ',
  Struct = ' 󰰣 ',
  TabNine = ' 󰏚 ',
  Text = ' 󱜥 ',
  TypeParameter = ' 󰰦 ',
  Unit = ' 󱜥 ',
  Value = '  ',
  Variable = ' 󰄛 ',
}

local txt_kind_icons = {
  Text = 'TXT',
  Method = 'MET',
  Function = 'FUN',
  Constructor = 'CTR',

  Field = 'FLD',
  Variable = 'VAR',
  Property = 'PRP',

  Class = 'CLS',
  Interface = 'ITF',
  Struct = 'STR',
  Module = 'MOD',

  Unit = 'UNT',
  Value = 'VAL',
  Enum = 'ENU',
  EnumMember = 'EMB',

  Keyword = 'KEY',
  Constant = 'CST',

  Snippet = 'SNP',
  Color = 'CLR',
  File = 'FIL',
  Reference = 'REF',
  Folder = 'FOL',
  Event = 'EVT',
  Operator = 'OPR',
  TypeParameter = 'TPR',
}

local cmp_kinds = {
  Text = '  ',
  Method = '  ',
  Function = '  ',
  Constructor = '  ',
  Field = '  ',
  Variable = '  ',
  Class = '  ',
  Interface = '  ',
  Module = '  ',
  Property = '  ',
  Unit = '  ',
  Value = '  ',
  Enum = '  ',
  Keyword = '  ',
  Snippet = '  ',
  Color = '  ',
  File = '  ',
  Reference = '  ',
  Folder = '  ',
  EnumMember = '  ',
  Constant = '  ',
  Struct = '  ',
  Event = '  ',
  Operator = '  ',
  TypeParameter = '  ',
}

local kind_icons = {
  Text = '',
  Method = '󰆧',
  Function = '󰊕',
  Constructor = '',
  Field = '󰇽',
  Variable = '󰂡',
  Class = '󰠱',
  Interface = '',
  Module = '',
  Property = '󰜢',
  Unit = '',
  Value = '󰎠',
  Enum = '',
  Keyword = '󰌋',
  Snippet = '',
  Color = '󰏘',
  File = '󰈙',
  Reference = '',
  Folder = '󰉋',
  EnumMember = '',
  Constant = '󰏿',
  Struct = '',
  Event = '',
  Operator = '󰆕',
  TypeParameter = '󰅲',
}

return function()
  local blinkcmp = require('blink.cmp')

  local opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- see the "default configuration" section below for full documentation on how to define
    -- your own keymap.
    keymap = {
      -- 'default' or 'super-tab' or 'enter'
      -- preset = 'default',
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

    completion = {

      keyword = {
        -- 'prefix' will fuzzy match on the text before the cursor
        -- 'full' will fuzzy match on the text before *and* after the cursor
        -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
        range = 'prefix',
        -- -- Regex used to get the text when fuzzy matching
        -- regex = '[-_]\\|\\k',
        -- -- After matching with regex, any characters matching this regex at the prefix will be excluded
        -- exclude_from_prefix_regex = '-',
      },

      trigger = {
        -- When true, will prefetch the completion items when entering insert mode
        prefetch_on_insert = false,
        -- When false, will not show the completion window automatically when in a snippet
        show_in_snippet = true,
        -- When true, will show the completion window after typing a character that matches the `keyword.regex`
        show_on_keyword = true,
        -- When true, will show the completion window after typing a trigger character
        show_on_trigger_character = true,
        -- LSPs can indicate when to show the completion window via trigger characters
        -- however, some LSPs (i.e. tsserver) return characters that would essentially
        -- always show the window. We block these by default.
        show_on_blocked_trigger_characters = { ' ', '\n', '\t' },
        -- or a function like
        -- show_on_blocked_trigger_characters = function()
        --   local blocked = { ' ', '\n', '\t' }
        --   if vim.bo.filetype == 'markdown' then
        --     vim.list_extend(blocked, { '.', '/', '(', '[' })
        --   end
        --   return blocked
        -- end
        -- When both this and show_on_trigger_character are true, will show the completion window
        -- when the cursor comes after a trigger character after accepting an item
        show_on_accept_on_trigger_character = true,
        -- When both this and show_on_trigger_character are true, will show the completion window
        -- when the cursor comes after a trigger character when entering insert mode
        show_on_insert_on_trigger_character = true,
        -- List of trigger characters (on top of `show_on_blocked_trigger_characters`) that won't trigger
        -- the completion window when the cursor comes after a trigger character when
        -- entering insert mode/accepting an item
        show_on_x_blocked_trigger_characters = { "'", '"', '(' },
        -- or a function, similar to show_on_blocked_trigger_character
      },

      list = {
        -- Maximum number of items to display
        max_items = 200,
        -- Controls if completion items will be selected automatically,
        -- and whether selection automatically inserts
        selection = {
          preselect = false,
          auto_insert = false,
        },
        -- Controls how the completion items are selected
        -- 'preselect' will automatically select the first item in the completion list
        -- 'manual' will not select any item by default
        -- 'auto_insert' will not select any item by default, and insert the completion items automatically
        -- when selecting them
        --
        -- You may want to bind a key to the `cancel` command, which will undo the selection
        -- when using 'auto_insert'
        cycle = {
          -- When `true`, calling `select_next` at the *bottom* of the completion list
          -- will select the *first* completion item.
          from_bottom = true,
          -- When `true`, calling `select_prev` at the *top* of the completion list
          -- will select the *last* completion item.
          from_top = true,
        },
      },

      accept = {
        -- Create an undo point when accepting a completion item
        create_undo_point = true,
        -- Experimental auto-brackets support
        auto_brackets = {
          -- Whether to auto-insert brackets for functions
          enabled = true,
          -- Default brackets to use for unknown languages
          default_brackets = { '(', ')' },
          -- Overrides the default blocked filetypes
          override_brackets_for_filetypes = {},
          -- Synchronously use the kind of the item to determine if brackets should be added
          kind_resolution = {
            enabled = true,
            blocked_filetypes = { 'typescriptreact', 'javascriptreact', 'vue' },
          },
          -- Asynchronously use semantic token to determine if brackets should be added
          semantic_token_resolution = {
            enabled = true,
            blocked_filetypes = {},
            -- How long to wait for semantic tokens to return before assuming no brackets should be added
            timeout_ms = 400,
          },
        },
      },

      menu = {
        enabled = true,
        min_width = 15,
        max_height = 10,
        border = 'none',
        winblend = 0,
        winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
        -- Keep the cursor X lines away from the top/bottom of the window
        scrolloff = 2,
        -- Note that the gutter will be disabled when border ~= 'none'
        scrollbar = true,
        -- Which directions to show the window,
        -- falling back to the next direction when there's not enough space
        direction_priority = { 's', 'n' },

        -- Whether to automatically show the window when new completion items are available
        auto_show = true,

        -- Screen coordinates of the command line
        cmdline_position = function()
          if vim.g.ui_cmdline_pos ~= nil then
            local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
            return { pos[1] - 1, pos[2] }
          end
          return { vim.o.lines - 1, 0 }
        end,

        -- Controls how the completion items are rendered on the popup window
        draw = {
          -- Aligns the keyword you've typed to a component in the menu
          -- align_to_component = 'label', -- or 'none' to disable
          -- Left and right padding, optionally { left, right } for different padding on each side
          padding = 1,
          -- Gap between columns
          gap = 1,
          -- Use treesitter to highlight the label text
          -- treesitter = false,

          -- Components to render, grouped by column

          -- columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, {'kind'} },
          columns = {
            -- { 'kind' },
            -- { 'kind_icon'},
            -- { 'label', 'label_description', gap = 1},
            -- { 'label' },
            -- { 'label_description' },
            -- { 'source_name_flex' },
            -- { 'kind_icon' },
            -- { 'label', 'label_description', gap = 1 },
            -- { 'kind' }
            --
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
            { 'kind' },
            { 'source_name_flex' },
          },

          -- columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
          -- for a setup similar to nvim-cmp: https://github.com/Saghen/blink.cmp/pull/245#issuecomment-2463659508
          -- columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },

          -- Definitions for possible components to render. Each component defines:
          --   ellipsis: whether to add an ellipsis when truncating the text
          --   width: control the min, max and fill behavior of the component
          --   text function: will be called for each item
          --   highlight function: will be called only when the line appears on screen
          components = {
            kind_icon = {
              -- ellipsis = false,
              -- width = {
              --   fill = false,
              --   min = 3,
              -- },
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

            kind = {
              ellipsis = false,
              width = { fill = true },
              text = function(ctx)
                return ctx.kind
              end,
              highlight = function(ctx)
                return require('blink.cmp.completion.windows.render.tailwind').get_hl(ctx)
                  -- or ('CmpItemKind' .. ctx.kind:sub(1, 1):upper() .. ctx.kind:sub(2))
                  or ('BlinkCmpKind' .. ctx.kind)
              end,
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
          },
        },
      },

      documentation = {
        -- Controls whether the documentation window will automatically show when selecting a completion item
        auto_show = true,
        -- Delay before showing the documentation window
        auto_show_delay_ms = 500,
        -- Delay before updating the documentation window when selecting a new item,
        -- while an existing item is still visible
        update_delay_ms = 50,
        -- Whether to use treesitter highlighting, disable if you run into performance issues
        treesitter_highlighting = true,
        window = {
          min_width = 10,
          max_width = 60,
          max_height = 20,
          border = 'padded',
          winblend = 0,
          winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
          -- Note that the gutter will be disabled when border ~= 'none'
          scrollbar = true,
          -- Which directions to show the documentation window,
          -- for each of the possible menu window directions,
          -- falling back to the next direction when there's not enough space
          direction_priority = {
            menu_north = { 'e', 'w', 'n', 's' },
            menu_south = { 'e', 'w', 's', 'n' },
          },
        },
      },

      -- Displays a preview of the selected item on the current line
      ghost_text = {
        enabled = false,
      },
    },

    signature = {
      enabled = true,
      trigger = {
        blocked_trigger_characters = {},
        blocked_retrigger_characters = {},
        -- When true, will show the signature help window when the cursor comes after a trigger character when entering insert mode
        show_on_insert_on_trigger_character = true,
      },
      window = {
        min_width = 1,
        max_width = 100,
        max_height = 10,
        border = 'padded',
        winblend = 0,
        winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
        scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
        -- Which directions to show the window,
        -- falling back to the next direction when there's not enough space,
        -- or another window is in the way
        direction_priority = { 'n', 's' },
        -- Disable if you run into performance issues
        treesitter_highlighting = true,
      },
    },

    fuzzy = {
      -- when enabled, allows for a number of typos relative to the length of the query
      -- disabling this matches the behavior of fzf
      -- use_typo_resistance = true,
      -- frecency tracks the most recently/frequently used items and boosts the score of the item
      use_frecency = true,
      -- proximity bonus boosts the score of items matching nearby words
      use_proximity = true,
      -- max_items = 200,
      -- controls which sorts to use and in which order, falling back to the next sort if the first one returns nil
      -- you may pass a function instead of a string to customize the sorting
      sorts = { 'score', 'kind', 'label' },

      prebuilt_binaries = {
        -- Whether or not to automatically download a prebuilt binary from github. If this is set to `false`
        -- you will need to manually build the fuzzy binary dependencies by running `cargo build --release`
        download = true,
        -- When downloading a prebuilt binary, force the downloader to resolve this version. If this is unset
        -- then the downloader will attempt to infer the version from the checked out git tag (if any).
        --
        -- Beware that if the FFI ABI changes while tracking main then this may result in blink breaking.
        force_version = nil,
        -- When downloading a prebuilt binary, force the downloader to use this system triple. If this is unset
        -- then the downloader will attempt to infer the system triple from `jit.os` and `jit.arch`.
        -- Check the latest release for all available system triples
        --
        -- Beware that if the FFI ABI changes while tracking main then this may result in blink breaking.
        force_system_triple = nil,
        -- Extra arguments that will be passed to curl like { 'curl', ..extra_curl_args, ..built_in_args }
        extra_curl_args = {},
      },
    },

    sources = {
      -- Static list of providers to enable, or a function to dynamically enable/disable providers based on the context
      default = {
        'lsp',
        'path',
        'snippets',
        'buffer',
        -- 'emoji',
      },
      -- Example dynamically picking providers based on the filetype and treesitter node:
      -- providers = function(ctx)
      --   local node = vim.treesitter.get_node()
      --   if vim.bo.filetype == 'lua' then
      --     return { 'lsp', 'path' }
      --   elseif node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
      --     return { 'buffer' }
      --   else
      --     return { 'lsp', 'path', 'snippets', 'buffer' }
      --   end
      -- end

      -- You may also define providers per filetype
      per_filetype = {
        -- lua = { 'lsp', 'path' },
      },

      -- By default, we choose providers for the cmdline based on the current cmdtype
      -- You may disable cmdline completions by replacing this with an empty table
      -- cmdline = function()
      --   local type = vim.fn.getcmdtype()
      --   -- Search forward and backward
      --   if type == '/' or type == '?' then
      --     return { 'buffer' }
      --   end
      --   -- Commands
      --   if type == ':' then
      --     return { 'cmdline' }
      --   end
      --   return {}
      -- end,
      cmdline = {},

      -- Function to use when transforming the items before they're returned for all providers
      -- The default will lower the score for snippets to sort them lower in the list
      -- transform_items = function(_, items)
      --   for _, item in ipairs(items) do
      --     if item.kind == require('blink.cmp.types').CompletionItemKind.Snippet then
      --       item.score_offset = item.score_offset - 3
      --     end
      --   end
      --   return items
      -- end,
      --
      -- Minimum number of characters in the keyword to trigger all providers
      -- May also be `function(ctx: blink.cmp.Context): number`
      min_keyword_length = 0,
      -- Example for setting a minimum keyword length for markdown files
      -- min_keyword_length = function()
      --   return vim.bo.filetype == 'markdown' and 2 or 0
      -- end,

      -- Please see https://github.com/Saghen/blink.compat for using `nvim-cmp` sources
      providers = {
        lsp = {
          name = 'LSP',
          module = 'blink.cmp.sources.lsp',

          --- *All* providers have the following options available
          --- NOTE: All of these options may be functions to get dynamic behavior
          --- See the type definitions for more information.
          enabled = true, -- Whether or not to enable the provider
          async = true, -- Whether we should wait for the provider to return before showing the completions
          timeout_ms = 2000, -- How long to wait for the provider to return before showing completions and treating it as asynchronous
          transform_items = nil, -- Function to transform the items before they're returned
          should_show_items = true, -- Whether or not to show the items
          max_items = nil, -- Maximum number of items to display in the menu
          min_keyword_length = 0, -- Minimum number of characters in the keyword to trigger the provider
          -- If this provider returns 0 items, it will fallback to these providers.
          -- If multiple providers falback to the same provider, all of the providers must return 0 items for it to fallback
          fallbacks = { 'buffer' },
          score_offset = 0, -- Boost/penalize the score of the items
          override = nil, -- Override the source's functions
        },
        path = {
          name = 'Path',
          module = 'blink.cmp.sources.path',
          score_offset = 3,
          opts = {
            trailing_slash = true,
            label_trailing_slash = true,
            get_cwd = function(context)
              return vim.fn.expand(('#%d:p:h'):format(context.bufnr))
            end,
            show_hidden_files_by_default = false,
          },
        },
        snippets = {
          name = 'Snippets',
          module = 'blink.cmp.sources.snippets',
          opts = {
            friendly_snippets = true,
            search_paths = { vim.fn.stdpath('config') .. '/snippets' },
            global_snippets = { 'all' },
            extended_filetypes = {},
            ignored_filetypes = {},
            get_filetype = function(context)
              return vim.bo.filetype
            end,
          },

          --- Example usage for disabling the snippet provider after pressing trigger characters (i.e. ".")
          -- enabled = function(ctx)
          --   return ctx ~= nil and ctx.trigger.kind == vim.lsp.protocol.CompletionTriggerKind.TriggerCharacter
          -- end,
        },
        -- luasnip = {
        --   name = 'Luasnip',
        --   module = 'blink.cmp.sources.luasnip',
        -- },
        buffer = {
          name = 'Buffer',
          module = 'blink.cmp.sources.buffer',
          opts = {
            -- default to all visible buffers
            get_bufnrs = function()
              return vim
                .iter(vim.api.nvim_list_wins())
                :map(function(win)
                  return vim.api.nvim_win_get_buf(win)
                end)
                :filter(function(buf)
                  return vim.bo[buf].buftype ~= 'nofile'
                end)
                :totable()
            end,
          },
        },
        -- emoji = {
        --   module = 'blink-emoji',
        --   name = 'Emoji',
        --   score_offset = 15, -- Tune by preference
        --   opts = { insert = true }, -- Insert emoji (default) or complete its name
        -- },
      },
    },

    appearance = {
      highlight_ns = vim.api.nvim_create_namespace('blink_cmp'),
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = false,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      -- nerd_font_variant = 'mono',
      nerd_font_variant = 'normal',
      kind_icons = v4_kink_icons,
      -- kind_icons = v3_kind_icons,
      -- kind_icons = txt_kind_icons,
    },
  }
  blinkcmp.setup(opts)
end
