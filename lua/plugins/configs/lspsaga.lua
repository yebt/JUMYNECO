return function()
  require('lspsaga').setup({
    border = 'single',
    --- No breadcrumbs
    symbol_in_winbar = {
      enable = false,
    },
    lightbulb ={
      -- enable = false,
      sign = true,
      virtual_text = false, -- cause an strantge error when the file is empty
    }
  })
end
