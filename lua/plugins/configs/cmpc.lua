return function()
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')
  local ndi = require('nvim-web-devicons')
  local lspkind = require('lspkind')
  -- local WIDE_HEIGHT = 40
  --

  local kind_icons = {
    Class = '  ',
    Color = '  ',
    Constant = '  ',
    Constructor = '  ',
    Enum = '  ',
    EnumMember = '  ',
    Event = '  ',
    Field = '  ',
    File = '  ',
    Folder = '  ',
    Function = '  ',
    Interface = '  ',
    Keyword = '  ',
    Method = '  ',
    Module = '  ',
    Operator = '  ',
    Property = '  ',
    Reference = '  ',
    Snippet = '  ',
    Struct = '  ',
    Text = '  ',
    TypeParameter = '  ',
    Unit = '  ',
    Value = '  ',
    Variable = '  ',
  }

  cmp.setup({

    enabled = function()
      local disabled = false
      disabled = disabled or (vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'prompt')
      disabled = disabled or (vim.fn.reg_recording() ~= '')
      disabled = disabled or (vim.fn.reg_executing() ~= '')
      return not disabled
    end,

    performance = {
      --- This is the interval used to group up completions from different sources for filtering and displaying
      -- debounce = 60,
      debounce = 60, -- ms before trigger
      --- This is used to delay filtering and displaying completions.
      -- throttle = 30,
      throttle = 30,
      -- fetching_timeout = 500,
      fetching_timeout = 100,
      -- confirm_resolve_timeout = 80,
      confirm_resolve_timeout = 80,
      -- async_budget = 1,
      async_budget = 1,
      -- max_view_entries = 200,
      max_view_entries = 50,
    },

    preselect = cmp.PreselectMode.Item,
    -- preselect = cmp.PreselectMode.None,

    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },

    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<Tab>'] = cmp.mapping(function(fallback)
        if vim.snippet.active({ direction = 1 }) then
          vim.snippet.jump(1)
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if vim.snippet.active({ direction = -1 }) then
          vim.snippet.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),

    completion = {
      autocomplete = {
        cmp.TriggerEvent.TextChanged,
      },
      -- completeopt = 'menu,menuone,noselect',
      keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
      keyword_length = 1,
    },

    -- sources = cmp.config.sources({
    --   { name = 'nvim_lsp' },
    -- }, {
    --   { name = 'buffer' },
    -- }),

    sources = cmp.config.sources({
      {
        name = 'nvim_lsp',
      },
      { name = 'snippets' },
      -- { name = 'supermaven' },
      -- { name = 'nvim_lsp_signature_help' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.

      -- }, {

      {
        name = 'buffer',
        option = {
          --- All
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end,
          --- Visible
          -- get_bufnrs = function()
          --   local bufs = {}
          --   for _, win in ipairs(vim.api.nvim_list_wins()) do
          --     bufs[vim.api.nvim_win_get_buf(win)] = true
          --   end
          --   return vim.tbl_keys(bufs)
          -- end,
        },
      },
      { name = 'path' },
    }),
    -- window = {
    --   completion = {
    --     border = { '', '', '', '', '', '', '', '' },
    --     winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
    --     winblend = vim.o.pumblend,
    --     scrolloff = 0,
    --     col_offset = 0,
    --     side_padding = 1,
    --     scrollbar = true,
    --   },
    --   documentation = {
    --     max_height = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
    --     max_width = math.floor((WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))),
    --     border = { '', '', '', ' ', '', '', '', ' ' },
    --     winhighlight = 'FloatBorder:NormalFloat',
    --     winblend = vim.o.pumblend,
    --   },
    -- },

    -- view = {
    --   -- can be "custom", "wildmenu" or "native"
    --   -- entries = 'native',
    --   -- entries = { name = 'custom', selection_order = 'near_cursor' },
    --
    --   -- entries = {
    --   --   name = 'custom',
    --   --   selection_order = 'top_down',
    --   --   follow_cursor = false,
    --   -- },
    --   docs = {
    --     auto_open = true,
    --   },
    -- },

    -- formatting = {
    --   expandable_indicator = true,
    --   fields = { 'abbr', 'kind', 'menu' },
    --   format = function(_, vim_item)
    --     return vim_item
    --   end,
    -- },
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol_text",
        menu = ({
          buffer = "[Bff]",
          nvim_lsp = "[LSP]",
          luasnip = "[LSnp]",
          nvim_lua = "[Lua]",
          latex_symbols = "[Ltx]",
          path = "[Pth]",
          snippets = "[Snp]",
        })
      }),
    },

    matching = {
      disallow_fuzzy_matching = false,
      disallow_fullfuzzy_matching = false,
      disallow_partial_fuzzy_matching = true,
      disallow_partial_matching = false,
      disallow_prefix_unmatching = false,
      disallow_symbol_nonprefix_matching = true,
    },
  })

  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end
