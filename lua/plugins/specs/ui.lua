local api = vim.api
local uv = vim.uv

return function(use)
  --- Dashboard
  use('nvimdev/dashboard-nvim')
  :depends("nvim-tree/nvim-web-devicons")
  :config(function()
    require('dashboard').setup{
    theme = 'hyper',
    config = {
      week_header = {
        enable = true,
      },
      project = {
        enable = false,
      },
      disable_move = true,
      shortcut = {
        {
          desc = 'Update',
          group = 'Include',
          action = 'Strive update',
          key = 'u',
        },
        {
          desc = 'Files',
          group = 'Function',
          action = 'FzfLua files',
          key = 'f',
        },
        {
          desc = 'Configs',
          group = 'Constant',
          action = 'FzfLua files cwd=$HOME/.config',
          key = 'd',
        },
      },
    },
  }
  end)
    :cond(function()
      return vim.fn.argc() == 0
        and api.nvim_buf_line_count(0) == 0
        and api.nvim_buf_get_name(0) == ''
    end)

  -- :config (function()
  --   require('dashboard').setup({
  --     -- theme = 'hyper',
  --     disable_move = true,
  --     config = {
  --       header={""},
  --       disable_move=true,
  -- packages = { enable = true },
  --     }
  --
  --     -- config = {
  --       --   header={""},
  --       --   week_header = {
  --         --     enable = false,
  --         --   },
  --         --   project = {
  --           --     enable = false,
  --           --   },
  --           --   disable_move = true,
  --           --   -- shortcut = {
  --             --   --   {
  --               --   --     desc = 'Update',
  --               --   --     group = 'Include',
  --               --   --     action = 'Strive update',
  --               --   --     key = 'u',
  --               --   --   },
  --               --   --   {
  --                 --   --     desc = 'Files',
  --                 --   --     group = 'Function',
  --                 --   --     action = 'FzfLua files',
  --                 --   --     key = 'f',
  --                 --   --   },
  --                 --   --   {
  --                   --   --     desc = 'Configs',
  --                   --   --     group = 'Constant',
  --                   --   --     action = 'FzfLua files cwd=$HOME/.config',
  --                   --   --     key = 'd',
  --                   --   --   },
  --                   --   -- },
  --                   -- },
  --                 })
  --               end)
  -- :cond(function()
  --   return vim.fn.argc() == 0
  --   and api.nvim_buf_line_count(0) == 0
  --   and api.nvim_buf_get_name(0) == ''
  -- end)
  -- :run('Dashboard')

  -- use 'echasnovski/mini.starter'
  --   :config(require('plugins.configs.mini-starter-c'))
  --   :cond(function()
    --     return vim.fn.argc() == 0
    --     and api.nvim_buf_line_count(0) == 0
    --     and api.nvim_buf_get_name(0) == ''
    --   end)
    --   :load() -- Load no lazy


    -- use('nvimdev/modeline.nvim'):on({ 'BufEnter */*', 'BufNewFile' }):setup()
    -- use('lewis6991/gitsigns.nvim'):on({ 'BufEnter */*', 'BufNewFile' }):setup({
      --   signs = {
        --     add = { text = '┃' },
        --     change = { text = '┃' },
        --     delete = { text = '_' },
        --     topdelete = { text = '‾' },
        --     changedelete = { text = '~' },
        --     untracked = { text = '┃' },
        --   },
        -- })
        -- use('nvimdev/dired.nvim'):cmd('Dired')

end

