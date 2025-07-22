return function()
  -- ==================================================

  --- Minifiles use the rename of the Snacks
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesActionRename',
    callback = function(event)
      Snacks.rename.on_rename_file(event.data.from, event.data.to)
    end,
  })

  --- Customize window
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesWindowOpen',
    callback = function(args)
      local win_id = args.data.win_id

      -- Customize window-local settings
      -- vim.wo[win_id].winblend = 50
      local config = vim.api.nvim_win_get_config(win_id)
      -- config.border, config.title_pos = 'single', 'right'
      config.border = 'single'
      config.title_pos = 'right'
      vim.api.nvim_win_set_config(win_id, config)
    end,
  })

  -- - Customize height
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesWindowUpdate',
    callback = function(args)
      local config = vim.api.nvim_win_get_config(args.data.win_id)

      -- Ensure fixed height
      -- config.height = 10

      -- Ensure no title padding
      local n = #config.title
      config.title[1][1] = config.title[1][1]:gsub('^ ', '')
      config.title[n][1] = config.title[n][1]:gsub(' $', '')

      vim.api.nvim_win_set_config(args.data.win_id, config)
    end,
  })

  -- Set focused directory as current working directory
  -- local set_cwd = function()
  --   local path = (MiniFiles.get_fs_entry() or {}).path
  --   if path == nil then return vim.notify('Cursor is not on valid entry') end
  --   vim.fn.chdir(vim.fs.dirname(path))
  -- end

  -- Yank in register full path of entry under cursor
  local yank_path = function()
    local path = (MiniFiles.get_fs_entry() or {}).path
    if path == nil then
      return vim.notify('Cursor is not on valid entry')
    end
    vim.fn.setreg(vim.v.register, path)
  end

  -- Open path with system default handler (useful for non-text files)
  local ui_open = function()
    vim.ui.open(MiniFiles.get_fs_entry().path)
  end

  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      local b = args.data.buf_id
      -- vim.keymap.set('n', 'g~', set_cwd,   { buffer = b, desc = 'Set cwd' })
      vim.keymap.set('n', 'gX', ui_open, { buffer = b, desc = 'OS open' })
      vim.keymap.set('n', 'gy', yank_path, { buffer = b, desc = 'Yank path' })
    end,
  })

  -- Marks
  local set_mark = function(id, path, desc)
    MiniFiles.set_bookmark(id, path, { desc = desc })
  end

  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesExplorerOpen',
    callback = function()
      -- set_mark('c', vim.fn.stdpath('config'), 'Config') -- path
      set_mark('w', vim.fn.getcwd, 'Working directory') -- callable
      -- set_mark('~', '~', 'Home directory')
    end,
  })

  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesExplorerOpen',
    callback = function()
      -- try load bookmarks for the project
      local cwd = vim.fn.getcwd()
      local bookmarksFileName = '.nvim/bookmarks.json'
      local bookmarksFilePath = cwd .. "/" .. bookmarksFileName
      local existFile = (vim.uv or vim.loop).fs_stat(bookmarksFilePath) ~= nil
      if (existFile) then
        local content = table.concat(vim.fn.readfile(bookmarksFilePath), "\n")
        -- local json_data = vim.json.decode(content)
        local ok, json_data = pcall(vim.json.decode, content)
        if not ok then
          vim.notify('error loading bookmarks project file')
          return
        end
        for index, value in pairs(json_data) do
          local bmdesc = ""
          local path = cwd .. "/"
          if type(value) == "table" then
            bmdesc = value['desc'] or value[1]
            path = path .. (value['path'] or value[2] or '')
          elseif type(value) == "string" then
            bmdesc = value
            path = path .. value
          end
          set_mark(index, path, bmdesc)
        end
      end
    end,
  })

  --- Map for open in splits
  local map_split = function(buf_id, lhs, direction)
    local rhs = function()
      -- Make new window and set it as target
      local cur_target = MiniFiles.get_explorer_state().target_window
      local new_target = vim.api.nvim_win_call(cur_target, function()
        vim.cmd(direction .. ' split')
        return vim.api.nvim_get_current_win()
      end)

      MiniFiles.set_target_window(new_target)

      -- This intentionally doesn't act on file under cursor in favor of
      -- explicit "go in" action (`l` / `L`). To immediately open file,
      -- add appropriate `MiniFiles.go_in()` call instead of this comment.
    end

    -- Adding `desc` will result into `show_help` entries
    local desc = 'Split ' .. direction
    vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
  end

  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      local buf_id = args.data.buf_id
      -- Tweak keys to your liking
      map_split(buf_id, '<C-s>', 'belowright horizontal')
      map_split(buf_id, '<C-v>', 'belowright vertical')
      -- map_split(buf_id, '<C-t>', 'tab')
      --
    end,
  })

  --- Create mapping to show/hide dot-files

  local show_dotfiles = true

  local filter_show = function(fs_entry) return true end

  local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, '.')
  end

  local toggle_dotfiles = function()
    show_dotfiles = not show_dotfiles
    local new_filter = show_dotfiles and filter_show or filter_hide
    MiniFiles.refresh({ content = { filter = new_filter } })
  end


  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      local buf_id = args.data.buf_id
      -- Tweak left-hand side of mapping to your liking
      vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
    end,
  })


  -- ==================================================
  local mf = require('mini.files')

  local opts = {
    -- Customization of shown content
    content = {
      -- Predicate for which file system entries to show
      filter = nil,
      -- What prefix to show to the left of file system entry
      prefix = nil,
      -- prefix = function ()
      -- end,
      -- In which order to show file system entries
      sort = nil,
    },

    -- Module mappings created only inside explorer.
    -- Use `''` (empty string) to not create one.
    mappings = {
      close = 'q',
      go_in = 'l',
      go_in_plus = '<cr>',
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
      use_as_default_explorer = false,
    },

    -- Customization of explorer windows
    windows = {
      -- Maximum number of windows to show side by side
      max_number = math.huge,
      -- Whether to show preview of file/directory under cursor
      preview = true,
      -- Width of focused window
      width_focus = 50,
      -- Width of non-focused window
      width_nofocus = 15,
      -- Width of preview window
      width_preview = 25,
    },
  }

  mf.setup(opts)
end
