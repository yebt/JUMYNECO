return function()
  require('lspsaga').setup({
    border = 'single',
    --- No breadcrumbs
    symbol_in_winbar = {
      enable = false,
    },
  })
end
