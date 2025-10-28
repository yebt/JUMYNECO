return function()
  ---@type blink.cmp.Config
  local opts = {
    --- GENERAL
    cmdline = { enabled = false },
    completion = {
    accept = { auto_brackets = { enabled = true }, },
      documentation = { auto_show = false },
    },

    keymap = {
      preset = 'default',
      ['<C-l>'] = { function(cmp) cmp.show({ providers = { 'snippets' }, initial_selected_item_idx = 1 }) end },
      ['<C-t>'] = { function(cmp) cmp.show({ providers = { 'lsp' } }) end },
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },


    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" }
  }

  require('blink.cmp').setup(opts)
end
