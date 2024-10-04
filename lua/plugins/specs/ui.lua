return {
  --- Notifycations
  {
    'echasnovski/mini.notify',
    version = false,
    event = { 'VeryLazy' },
    config = require('plugins.configs.mininotifyc'),
  },

  --- Visit tracker
  { 'echasnovski/mini.visits', event = { 'LazyFile', 'VeryLazy' }, version = false, opts = {} },

  --- Starter view
  {
    'echasnovski/mini.starter',
    version = false,
    event = 'VimEnter',
    dependencies = {
      { 'echasnovski/mini.sessions', version = false },
    },
    cond = function()
      local lines = vim.api.nvim_buf_get_lines(0, 0, 2, false)
      local skip = vim.fn.argc() > 0 -- don't start with a init with a file
        or #lines > 1 -- don't open if curent buffer has more then 1 line
        or (#lines == 1 and lines[1]:len() > 0) -- don't open the current buffer if it has anything on the firt lione
        or #vim.tbl_filter(function(bufnr)
            return vim.bo[bufnr].buflisted
          end, vim.api.nvim_list_bufs())
          > 1 -- don't open if any listed buffers
        or not vim.o.modifiable -- don't open if not modifiable

      if not skip then
        for _, arg in pairs(vim.v.argv) do
          if arg == '-b' or arg == '-c' or vim.startswith(arg, '+') or arg == '-S' then
            skip = true
            break
          end
        end
      end
      return not skip
    end,
    config = require('plugins.configs.ministarterc'),
  },

  --- Inputs
  {
    'stevearc/dressing.nvim',
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.select(...)
      end

      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.input(...)
      end
    end,
    config = require('plugins.configs.dressingc'),
  },

  --- Fold
  {
    'kevinhwang91/nvim-ufo',
    event = 'VeryLazy',
    dependencies = {
      'kevinhwang91/promise-async',
    },
    keys = {
      {
        'zR',
        function(...)
          require('ufo').openAllFolds(...)
        end,
      },
      {
        'zM',
        function(...)
          require('ufo').closeAllFolds(...)
        end,
      },
    },
    config = require('plugins.configs.ufoc'),
  },

  --- Beter quickfix
  {
    'stevearc/quicker.nvim',
    event = 'FileType qf',
    keys = {
      {
        '<leader>lq',
        function()
          require('quicker').toggle({ loclist = true })
        end,
        desc = 'Toggle loclist',
      },
    },
    config = require('plugins.configs.quickerc'),
  },

  --- Buffer switcher
  -- {
  --   'mong8se/buffish.nvim',
  --   cmd = { 'Buffish' },
  --
  -- },

  {
    'leath-dub/snipe.nvim',
    keys = {
      {
        'gb',
        function()
          require('snipe').open_buffer_menu()
        end,
        desc = 'Open Snipe buffer menu',
      },
    },
    opts = {
      ui = {
        max_width = -1, -- -1 means dynamic width
        -- Where to place the ui window
        -- Can be any of "topleft", "bottomleft", "topright", "bottomright", "center", "cursor" (sets under the current cursor pos)
        position = 'bottomright',
      },
      hints = {
        -- Charaters to use for hints (NOTE: make sure they don't collide with the navigation keymaps)
        dictionary = 'sadflewcmpghio',
      },
      navigate = {
        -- When the list is too long it is split into pages
        -- `[next|prev]_page` options allow you to navigate
        -- this list
        next_page = 'J',
        prev_page = 'K',

        -- You can also just use normal navigation to go to the item you want
        -- this option just sets the keybind for selecting the item under the
        -- cursor
        under_cursor = '<cr>',

        -- In case you changed your mind, provide a keybind that lets you
        -- cancel the snipe and close the window.
        cancel_snipe = '<esc>',
      },
      -- Define the way buffers are sorted by default
      -- Can be any of "default" (sort buffers by their number) or "last" (sort buffers by last accessed)
      sort = 'default',
    },
  },

  --- Buffertag
  -- {
  --   'b0o/incline.nvim',
  --   event = 'VeryLazy',
  --   init = function()
  --     vim.opt.laststatus = 3
  --     vim.opt.showtabline = 0
  --   end,
  --   config = require('plugins.configs.inclinec'),
  -- },

  --- UI
  {
    'prichrd/netrw.nvim',
    ft = 'netrw',
    dependencies = {
      'nvim-web-devicons'
    },
    opts = {
      -- File icons to use when `use_devicons` is false or if
      -- no icon is found for the given file type.
      icons = {
        symlink = '󰒖',
        directory = '󰉋',
        file = '󰈔',
      },
      -- Uses mini.icon or nvim-web-devicons if true, otherwise use the file icon specified above
      use_devicons = true,
      mappings = {
        -- Function mappings receive an object describing the node under the cursor
        ['p'] = function(payload)
          print(vim.inspect(payload))
        end,
        -- String mappings are executed as vim commands
        ['<Leader>p'] = ":echo 'hello world'<CR>",
      },
    },
    init = function ()
      -- vim.g.netrw_browse_split = 4
      vim.g.netrw_browse_split = 2
	    vim.g.netrw_winsize   = 30
      vim.g.netrw_liststyle = 3
      -- vim.g.netrw_banner = 1
      vim.g.netrw_hide = 1
      vim.g.netrw_keepdir = 1
    end
  },
}
