return function()
  require('litee.lib').setup({
    tree = {
      icon_set = 'codicons',
    },
    panel = {
      orientation = 'left',
      panel_size = 30,
    },
  })
  require('litee.filetree').setup({})

end
