return function()
  local dired = require('dired')

  local opts = {
    path_separator = '/', -- Use '/' as the path separator
    show_hidden = false, -- Show hidden files
    show_icons = true, -- Show icons (patched font required)
    show_banner = true, -- Do not show the banner
    hide_details = true, -- Show file details by default
    sort_order = 'name', -- Sort files by name by default

    -- Define keybindings for various 'dired' actions
    keybinds = {
      dired_enter = '<cr>',
      dired_back = '-',
      dired_up = '_',
      dired_rename = 'R',
      -- ... (add more keybindings as needed)
      dired_quit = 'q',
    },

    -- Define colors for different file types and attributes
    colors = {
      DiredDimText = { link = {}, bg = 'NONE', fg = '505050', gui = 'NONE' },
      DiredDirectoryName = { link = {}, bg = 'NONE', fg = '9370DB', gui = 'NONE' },
      -- ... (define more colors as needed)
      DiredMoveFile = { link = {}, bg = 'NONE', fg = 'ff3399', gui = 'bold' },
    },
  }

  dired.setup(opts)
end
