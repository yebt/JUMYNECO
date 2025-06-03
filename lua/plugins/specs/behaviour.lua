--- Plugins to change the behaviour

return {
  --- which key
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts_extend = { 'spec' },
    opts = {
      preset = 'helix',
      -- delay = 10,
      spec = {
        -- {
        --   {
        --     mode={'n','x'},
        --     {'<leader>gh', group = "Gitsigns"}
        --   }
        -- }
      },
      triggers = {
        --- Default
        -- { "<auto>", mode = "nxso" },
        --- trigger on a builtin keymap
        { '<auto>', mode = 'nixsotc' },
        { 'a', mode = { 'n', 'v' } },
      },
      win = {
        wo = {
          winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
        },
      },
      -- expand = function()
      --   return true
      -- end
      expand = function(node)
        return not node.desc -- expand all nodes without a description
      end,
      icons = {
        -- colors = false,
        rules = false,
      },
      -- loop = true
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
      {
        '<c-w><space>',
        function()
          require('which-key').show({ keys = '<c-w>', loop = true })
        end,
        desc = 'Window Hydra Mode (which-key)',
      },
    },
  },

  --- Good practices
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
  },
}
