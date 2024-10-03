return function()
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')
  local use_path_icon = false
  local use_kind_icons = false
  local use_atom_view = false
  local use_tailwind_tools = false

  local nwd = require('nvim-web-devicons')

  -- local cmp_kinds = {
  --   Text = '  ',
  --   Method = '  ',
  --   Function = '  ',
  --   Constructor = '  ',
  --   Field = '  ',
  --   Variable = '  ',
  --   Class = '  ',
  --   Interface = '  ',
  --   Module = '  ',
  --   Property = '  ',
  --   Unit = '  ',
  --   Value = '  ',
  --   Enum = '  ',
  --   Keyword = '  ',
  --   Snippet = '  ',
  --   Color = '  ',
  --   File = '  ',
  --   Reference = '  ',
  --   Folder = '  ',
  --   EnumMember = '  ',
  --   Constant = '  ',
  --   Struct = '  ',
  --   Event = '  ',
  --   Operator = '  ',
  --   TypeParameter = '  ',
  -- }

  -- local frommer = {
  --   buffer = '[Buffer]',
  --   nvim_lsp = '[LSP]',
  --   luasnip = '[LuaSnip]',
  --   nvim_lua = '[Lua]',
  --   latex_symbols = '[LaTeX]',
  -- }

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
    Supermaven = '󰫺',
  }

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    window = {
      completion = use_atom_view and {
        winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
        col_offset = -3,
        side_padding = 0,
      } or nil,
      -- and
      -- cmp.config.window.bordered(),
      -- completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
      fields = use_atom_view and { 'kind', 'abbr', 'menu' } or nil,
      format = function(entry, vim_item)
        if (not use_atom_view) and not use_kind_icons and not use_tailwind_tools then
          return vim_item
        end

        if use_kind_icons then
          -- Kind icons
          vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
          -- Source
          vim_item.menu = ({
            buffer = '[Bff]',
            nvim_lsp = '[LSP]',
            luasnip = '[Lsp]',
            nvim_lua = '[Lua]',
            snippets = '[Snp]',
            latex_symbols = '[LTX]',
            supermaven = '[SM]',
            path = '[Path]',
          })[entry.source.name]

          return vim_item
        end

        if use_tailwind_tools then
          return require('lspkind').cmp_format({
            symbol_map = {
              Supermaven = '󰫺',
            },
            before = require('tailwind-tools.cmp').lspkind_format,
          })(entry, vim_item)
        end

        local vicon = nil
        local vhgr = nil

        if vim.tbl_contains({ 'path' }, entry.source.name) then
          if vim_item.kind == 'Folder' then
            vicon = '󰉋'
          else
            local icon, hl_group = nwd.get_icon(entry:get_completion_item().label)
            if icon then
              vicon = icon
              vhgr = hl_group
            else
              vicon = '󰈔'
            end
          end
        else
          vicon = kind_icons[vim_item.kind]
        end

        local txt = vim_item.kind or 'unknow'
        vim_item.kind = ' ' .. (vicon or '') .. ' '
        if vhgr then
          vim_item.hl_group = vhgr
        end
        vim_item.menu = '    (' .. (txt:lower()) .. ')'

        return vim_item
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<Tab>'] = cmp.mapping(function(fallback)
        -- if cmp.visible() then
        --   cmp.select_next_item()
        -- elseif vim.snippet.active({ direction = 1 }) then
        if vim.snippet.active({ direction = 1 }) then
          vim.snippet.jump(1)
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        -- if cmp.visible() then
        --   cmp.select_prev_item()
        -- elseif vim.snippet.active({ direction = -1 }) then
        if vim.snippet.active({ direction = -1 }) then
          vim.snippet.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      {
        name = 'nvim_lsp',
      },
      { name = 'snippets' },
      { name = 'supermaven' },
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
    performance = {
      -- -- debounce = 60,
      -- debounce = 60,
      -- -- throttle = 30,
      -- throttle = 10,
      -- -- fetching_timeout = 500,
      -- fetching_timeout = 1,
      -- -- confirm_resolve_timeout = 80,
      -- async_budget = 2,
      -- -- async_budget = 100,
      -- -- max_view_entries = 200,
      -- -- max_view_entries = 100
      -- max_view_entries = 5
    },

    -- performance = {
    --   trigger_debounce_time = 500,
    --   throttle = 550,
    --   fetching_timeout = 80,
    -- },
  })

  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

  if use_atom_view then
    require('plugins.configs.cmp_color')
  else
    vim.api.nvim_set_hl(0, 'CmpItemKindSupermaven', { fg = '#6CC644' })
  end
end
