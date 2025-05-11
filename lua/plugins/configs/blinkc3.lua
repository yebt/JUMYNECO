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
          "'",
          '"',
          '(',
          '{',
          '[',
        },
      },
      list = {
        max_items = 200,
        selection = {
          preselect = true,
          auto_insert = false,
        },
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
        },
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
              text = function(ctx)
                return ' ' .. ctx.kind_icon .. ctx.icon_gap .. ' '
              end,
              -- Set the highlight priority to 20000 to beat the cursorline's default priority of 10000
              highlight = function(ctx)
                return { { group = ctx.kind_hl, priority = 20000 } }
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        border = 'single',
        auto_show_delay_ms = 500,
        update_delay_ms = 50,
      },
      ghost_text = {
        enabled = true,
      },
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
      },
    },

    fuzzy = {
      implementation = 'prefer_rust_with_warning',
      use_frecency = true,
      use_proximity = true,
      use_unsafe_no_lock = false,
      sorts = {

        -- Deprioritize
        -- function(a, b)
        --   -- if (not a or not b)
        --   --     or (a.source_id == nil or b.source_id == nil)
        --   --     or (a.source_id == b.source_id)
        --   -- then
        --   --   return false
        --   -- end
        --
        --   return (a and a.source_id or nil) == 'ripgrep'
        -- end,

        -- (optionally) always prioritize exact matches
        'exact',

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
      -- default = {'lsp'}, --- for test
      min_keyword_length = 0,
      providers = {

        buffer = {
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
            end
          }

        },

        -- lsp = { fallbacks = {} },
        --

        ripgrep = {
          module = 'blink-ripgrep',
          name = 'Ripgrep',
          score_offset = -100, -- Depriorize totaly
          -- the options below are optional, some default values are shown
          ---@module "blink-ripgrep"
          ---@type blink-ripgrep.Options
          opts = {
            -- For many options, see `rg --help` for an exact description of
            -- the values that ripgrep expects.

            -- the minimum length of the current word to start searching
            -- (if the word is shorter than this, the search will not start)
            prefix_min_len = 3,

            -- The number of lines to show around each match in the preview
            -- (documentation) window. For example, 5 means to show 5 lines
            -- before, then the match, and another 5 lines after the match.
            context_size = 5,

            -- The maximum file size of a file that ripgrep should include in
            -- its search. Useful when your project contains large files that
            -- might cause performance issues.
            -- Examples:
            -- "1024" (bytes by default), "200K", "1M", "1G", which will
            -- exclude files larger than that size.
            max_filesize = '1M',

            -- Specifies how to find the root of the project where the ripgrep
            -- search will start from. Accepts the same options as the marker
            -- given to `:h vim.fs.root()` which offers many possibilities for
            -- configuration. If none can be found, defaults to Neovim's cwd.
            --
            -- Examples:
            -- - ".git" (default)
            -- - { ".git", "package.json", ".root" }
            project_root_marker = '.git',

            -- Enable fallback to neovim cwd if project_root_marker is not
            -- found. Default: `true`, which means to use the cwd.
            project_root_fallback = true,

            -- The casing to use for the search in a format that ripgrep
            -- accepts. Defaults to "--ignore-case". See `rg --help` for all the
            -- available options ripgrep supports, but you can try
            -- "--case-sensitive" or "--smart-case".
            search_casing = '--ignore-case',

            -- (advanced) Any additional options you want to give to ripgrep.
            -- See `rg -h` for a list of all available options. Might be
            -- helpful in adjusting performance in specific situations.
            -- If you have an idea for a default, please open an issue!
            --
            -- Not everything will work (obviously).
            additional_rg_options = {},

            -- When a result is found for a file whose filetype does not have a
            -- treesitter parser installed, fall back to regex based highlighting
            -- that is bundled in Neovim.
            fallback_to_regex_highlighting = true,

            -- Absolute root paths where the rg command will not be executed.
            -- Usually you want to exclude paths using gitignore files or
            -- ripgrep specific ignore files, but this can be used to only
            -- ignore the paths in blink-ripgrep.nvim, maintaining the ability
            -- to use ripgrep for those paths on the command line. If you need
            -- to find out where the searches are executed, enable `debug` and
            -- look at `:messages`.
            ignore_paths = {
              'node_modules',
              'vendor',
            },

            -- Any additional paths to search in, in addition to the project
            -- root. This can be useful if you want to include dictionary files
            -- (/usr/share/dict/words), framework documentation, or any other
            -- reference material that is not available within the project
            -- root.
            additional_paths = {},

            -- Keymaps to toggle features on/off. This can be used to alter
            -- the behavior of the plugin without restarting Neovim. Nothing
            -- is enabled by default. Requires folke/snacks.nvim.
            toggles = {
              -- The keymap to toggle the plugin on and off from blink
              -- completion results. Example: "<leader>tg"
              on_off = nil,
            },

            -- Features that are not yet stable and might change in the future.
            -- You can enable these to try them out beforehand, but be aware
            -- that they might change. Nothing is enabled by default.
            future_features = {
              backend = {
                -- The backend to use for searching. Defaults to "ripgrep".
                -- Available options:
                -- - "ripgrep", always use ripgrep
                -- - "gitgrep", always use git grep
                -- - "gitgrep-or-ripgrep", use git grep if possible, otherwise
                --   ripgrep
                use = 'ripgrep',
              },
            },

            -- Show debug information in `:messages` that can help in
            -- diagnosing issues with the plugin.
            debug = false,
          },
          -- (optional) customize how the results are displayed. Many options
          -- are available - make sure your lua LSP is set up so you get
          -- autocompletion help
          transform_items = function(_, items)
            for _, item in ipairs(items) do
              -- example: append a description to easily distinguish rg results
              item.labelDetails = {
                description = '(rg)',
              }
            end
            return items
          end,
        },
      },
    },

    cmdline = {
      enabled = false,
    },

    appearance = {
      use_nvim_cmp_as_default = false,
      -- mono, normal
      nerd_font_variant = 'mono',
      -- kind_icons = custom_icons.kind.text_compact
    },
  }
  blinkcmp.setup(opts)
end
