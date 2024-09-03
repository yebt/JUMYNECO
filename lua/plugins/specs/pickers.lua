return {
  --- Telescope
  -- {
  --   'nvim-telescope/telescope.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --   },
  --   cmd = 'Telescope',
  --   keys = {
  --     {
  --       '<leader>T<space>',
  --       ':Telescope<CR>',
  --       desc = 'Open telescope',
  --     },
  --     {
  --       '<C-p>',
  --       function()
  --         require('telescope.builtin').find_files({
  --           prompt_prefix = ' ',
  --           prompt_title = '',
  --           -- selection_caret = "* ",
  --           multi_icon = '- ',
  --           attach_mappings = function(_, map)
  --             map('i', '<ESC>', require('telescope.actions').close)
  --             return true
  --           end,
  --           results_title = false,
  --           sorting_strategy = 'ascending',
  --           layout_strategy = 'center',
  --           layout_config = {
  --             -- preview_cutoff = 1, -- Preview should always show (unless previewer = false)
  --             -- preview_cutoff = 0, -- Preview should always show (unless previewer = false)
  --             -- width = 0.5,
  --             width = 70,
  --             -- height = 12,
  --             -- preview_cutoff = 120,
  --             anchor = 'N',
  --           },
  --           -- -- border = false,
  --           border = true,
  --           borderchars = {
  --             prompt = { '─', '│', ' ', '│', '╭', '╮', '│', '│' },
  --             results = { '─', '│', '─', '│', '├', '┤', '╯', '╰' },
  --             preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
  --           },
  --         })
  --       end,
  --       silent = true,
  --       desc = 'Telescope fast ff',
  --     },
  --   },
  -- },

  --- Picker

  {
    'echasnovski/mini.pick',
    version = false,
    cmd = { 'Pick' },
    dependencies = {
      { 'echasnovski/mini.extra', version = false },
    },
    keys = {
      {
        '<C-p>',
        function()
          MiniPick.builtin.files({ tool = 'rg' })
        end,

        desc = 'Search the fiels in path',
      },
      {
        '<M-p>',
        "<CMD>Pick registry<CR>",
        silent = true,
        desc = 'Search the fiels in path',
      },
      {
        '<leader>b',
        function()
          if MiniPick.registry.bufferlist then
            MiniPick.registry.bufferlist()
          end
        end,

        desc = 'Pick orderer buffers',
      },
    },
    init = function()
      local au = vim.api.nvim_create_autocmd
      local function augroup(name)
        return vim.api.nvim_create_augroup('_kernel_' .. name, { clear = true })
      end

      vim.ui.select = function(...)
        vim.ui.select = require('mini.pick').ui_select
        return vim.ui.select(...)
      end

      -- vim.keymap.set('n', '<C-b>', function()
      --   local bfs = _G._kernel._bufferslist
      --   vim.notify(vim.inspect(bfs or 'No BL'))
      -- end, { desc = 'Print the list of buffers' })

      -- Init the list
      if not vim.g._bufferslist then
        vim.g._bufferslist = {}
      end

      local gbl = augroup('buffersl')
      au({ 'BufWinEnter', 'WinEnter' }, {
        group = gbl,
        callback = function(args)
          vim.g._bufferslist[args.buf] = vim.fn.reltimefloat(vim.fn.reltime())
        end,
      })

      au({ 'BufDelete' }, {
        group = gbl,
        callback = function(args)
          vim.g._bufferslist[args.buf] = null
        end,
      })
    end,
    config = require('plugins.configs.minipick'),
  },
}
