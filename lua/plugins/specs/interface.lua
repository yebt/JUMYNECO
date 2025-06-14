--- UI Interfaces
return {

  --- My status line, sorry, im trash
  -- {
  --   -- "yebt/fastline.nvim",
  --   dir = '/home/de-web/Develop/repositories/fastline.nvim',
  --   -- event = 'VeryLazy',
  --   dev = true,
  --   lazy = false,
  --   opts = {
  --     separator = '',
  --     sections = {
  --       left = {
  --         -- 'filename',
  --         'gitinfo',
  --         -- 'git',
  --
  --         -- { text = ' %f ', hl = 'FastlineFilenameR' },
  --         -- { text = '%h%w%m%r', hl = 'FastlineFilename' },
  --         -- { text = '%{&fileencoding}', hl = 'FastlineEncoding' },
  --       },
  --       center = { 'lsp' },
  --       right = { 'startup', 'mode' },
  --       -- puedes agregar "git", "filename", etc.
  --     },
  --   },
  --   -- config = function()
  --   --   require('fastline').register('clock', function()
  --   --     return os.date('%H:%M:%S')
  --   --   end)
  --   --
  --   --   require('fastline').setup({
  --   --     -- separator = "",
  --   --     sections = {
  --   --       left = {
  --   --         "mode",
  --   --         -- { text = " | ", hl = "FastlineSeparator" },
  --   --         -- { text = "%{&fileencoding}", hl = "FastlineEncoding" },
  --   --       },
  --   --       -- center = { "filename" },
  --   --       right = {"startup", "lsp", "git" },
  --   --
  --   --       -- left = { 'mode' },
  --   --       -- center = {},
  --   --       -- right = { 'clock' },
  --   --     },
  --   --   })
  --   -- end,
  -- },

  --- Modeline
  -- {
  --   "nvimdev/modeline.nvim",
  --   event = "VeryLazy",
  --   opts  = {},
  -- },

  --- Lualine
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   dependencies = { 'nvim-tree/nvim-web-devicons' },
  --   event = "VeryLazy",
  --   opts = {
  --     options = {
  --       component_separators = {},
  --       section_separators = {},
  --       -- theme = 'iceberg_dark',
  --     },
  --     sections = {
  --       lualine_a = {'branch'},
  --       lualine_b = {'hostname'},
  --       lualine_c = {'lsp_status'},
  --       lualine_x = {},
  --       lualine_y = {'selectioncount','searchcount','progress'},
  --       lualine_z = {{ 'mode', fmt = function(str) return str:sub(1,3) end }},
  --     },
  --
  --     winbar = {
  --       lualine_a = {},
  --       lualine_b = {{'filetype', icon_only = true}},
  --       lualine_c = {
  --         [[%#Comment#%<%{expand("%:h")}%{%(bufname() !=# '' ? '/' : '')%}%#Constant#%t%#ModeMsg#%{%(bufname() !=# '' ? ' %y' : '')%}%* %H%W%M%R%#Normal#]]},
  --       lualine_x = {},
  --       lualine_y = {},
  --       lualine_z = {}
  --     },
  --   },
  -- }

  --- Icons
  -- mini.icons
  {
    'echasnovski/mini.icons',
    lazy = true,
    opts = {
      file = {
        ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
        ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
      },
      filetype = {
        dotenv = { glyph = '', hl = 'MiniIconsYellow' },
      },
    },
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
  },
}
