return function()
  local mf = require('mini.files')
  -- No need to copy this inside `setup()`. Will be used automatically.
  local options = {
    -- Customization of shown content
    content = {
      -- Predicate for which file system entries to show
      filter = nil,
      -- What prefix to show to the left of file system entry
      prefix = nil,
      -- In which order to show file system entries
      sort = nil,
    },

    -- Module mappings created only inside explorer.
    -- Use `''` (empty string) to not create one.
    mappings = {
      close = 'q',
      go_in = 'l',
      go_in_plus = '<CR>',
      go_out = 'h',
      go_out_plus = '-',
      mark_goto = "'",
      mark_set = 'm',
      reset = '<BS>',
      reveal_cwd = '@',
      show_help = 'g?',
      synchronize = '=',
      trim_left = '<',
      trim_right = '>',
    },

    -- General options
    options = {
      -- Whether to delete permanently or move into module-specific trash
      permanent_delete = true,
      -- Whether to use for editing directories
      use_as_default_explorer = true,
    },

    -- Customization of explorer windows
    windows = {
      -- Maximum number of windows to show side by side
      max_number = math.huge,
      -- max_number = 2,
      -- Whether to show preview of file/directory under cursor
      -- preview = true,
      -- Width of focused window
      width_focus = 50,
      -- Width of non-focused window
      width_nofocus = 15,
      -- Width of preview window
      width_preview = 25,
    },
  }

  mf.setup(options)

  --- Customize Windows
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesWindowOpen',
    callback = function(args)
      local win_id = args.data.win_id

      -- Customize window-local settings
      vim.wo[win_id].winblend = 50
      local config = vim.api.nvim_win_get_config(win_id)
      config.border = 'single'
      config.title_pos = 'right'
      vim.api.nvim_win_set_config(win_id, config)
    end,
  })

  --- Map splits

  -- local map_split = function(buf_id, lhs, direction)
  --   local rhs = function()
  --     -- Make new window and set it as target
  --     local cur_target = MiniFiles.get_explorer_state().target_window
  --     local new_target = vim.api.nvim_win_call(cur_target, function()
  --       vim.cmd(direction .. ' split')
  --       return vim.api.nvim_get_current_win()
  --     end)
  --
  --     MiniFiles.set_target_window(new_target)
  --   end
  --
  --   -- Adding `desc` will result into `show_help` entries
  --   local desc = 'Split ' .. direction
  --   vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
  -- end
  --
  -- vim.api.nvim_create_autocmd('User', {
  --   pattern = 'MiniFilesBufferCreate',
  --   callback = function(args)
  --     local buf_id = args.data.buf_id
  --     -- Tweak keys to your liking
  --     map_split(buf_id, '<C-s>', 'belowright horizontal')
  --     map_split(buf_id, '<C-v>', 'belowright vertical')
  --   end,
  -- })

  -- local list_bookmarks = function(path)
  --   local mf_state = MiniFiles.get_explorer_state()
  --   if mf_state then
  --     local bks = mf_state.bookmarks
  --     if bks and #bks > 0 then
  --       vim.ui.select(bks, {
  --           prompt = 'Select bookmark',
  --           format_item = function(item)
  --               return " " .. item
  --           end,
  --       }, function(choice)
  --         vim.notify(vim.inspect(choice))
  --           -- if choice == 'spaces' then
  --           --     vim.o.expandtab = true
  --           -- else
  --           --     vim.o.expandtab = false
  --           -- end
  --       end)
  --     end
  --     vim.notify(vim.inspect({bks,#bks}))
  --   end
  -- end
  --
  -- vim.api.nvim_create_autocmd('User', {
  --   pattern = 'MiniFilesBufferCreate',
  --   callback = function(args)
  --     vim.keymap.set('n', "'", list_bookmarks, { buffer = args.data.buf_id })
  --   end,
  -- })
end
