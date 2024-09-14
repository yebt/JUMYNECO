return function()
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')

  local use_path_icon = false
  local use_kind_icons = false
  local use_atom_view = false

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
  }

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    window = {
      completion = use_atom_view and  {
        winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
        col_offset = -3,
        side_padding = 0,
      } or nil ,
        -- and
        -- cmp.config.window.bordered(),
      -- completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
      fields = use_atom_view and { 'kind', 'abbr', 'menu' }
      or nil,
      format = function(entry, vim_item)
        if not use_atom_view then
          return vim_item
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
      { name = 'nvim_lsp' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'snippets'},
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
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
  })

  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

  if use_atom_view then
    require('plugins.configs.cmp_color')
  end
end
