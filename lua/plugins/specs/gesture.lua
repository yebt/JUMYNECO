return {

  --- Flash
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    vscode = true,
    ---@type Flash.Config
    opts = {
      modes = {
        search = {
          enabled = true,
        },
        char = {
          jump_labels = true,
          -- labels = "abcdefghijklmnopqrstuvwxyz",
          -- labels = "asdfghjklqwertyuiopzxcvbnm",
          label = { exclude = 'hjkliardcsgx' },
        },
      },
    },
    keys = {
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
      { 'f', mode = { 'x', 'n' } },
      { 'F', mode = { 'x', 'n' } },
      { 't', mode = { 'x', 'n' } },
      { 'T', mode = { 'x', 'n' } },
      { ';', mode = { 'x', 'n' } },
      { ',', mode = { 'x', 'n' } },
      -- Show diagnostics at target, without changing cursor position
      -- {
      --   '<leader><leader>d',
      --   function()
      --     require('flash').jump({
      --       action = function(match, state)
      --         vim.api.nvim_win_call(match.win, function()
      --           vim.api.nvim_win_set_cursor(match.win, match.pos)
      --           vim.diagnostic.open_float()
      --         end)
      --         state:restore()
      --       end,
      --     })
      --   end,
      --   mode = { 'x', 'n' },
      --   desc = 'Show diagnostic at target',
      -- },

      -- Show diagnostics at target, without changing cursor position, also highlights diagnostics
      -- {
      --   '<leader><leader>D',
      --   function()
      --     require('flash').jump({
      --       matcher = function(win)
      --         ---@param diag Diagnostic
      --         return vim.tbl_map(function(diag)
      --           return {
      --             pos = { diag.lnum + 1, diag.col },
      --             end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
      --           }
      --         end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)))
      --       end,
      --       action = function(match, state)
      --         vim.api.nvim_win_call(match.win, function()
      --           vim.api.nvim_win_set_cursor(match.win, match.pos)
      --           vim.diagnostic.open_float()
      --         end)
      --         state:restore()
      --       end,
      --     })
      --   end,
      --   mode = { 'x', 'n' },
      --   desc = 'show diagnostic advanced',
      -- },
      -- Match beginning of words only
      -- {
      --   '<leader><leader>w',
      --   function()
      --     require('flash').jump({
      --       search = {
      --         mode = function(str)
      --           return '\\<' .. str
      --         end,
      --       },
      --     })
      --   end,
      --   mode = { 'x', 'n' },
      -- },
      -- select any word
      -- {
      --   '<leader><leader>W',
      --   function()
      --     require('flash').jump({
      --       pattern = '.', -- initialize pattern with any char
      --       search = {
      --         mode = function(pattern)
      --           -- remove leading dot
      --           if pattern:sub(1, 1) == '.' then
      --             pattern = pattern:sub(2)
      --           end
      --           -- return word pattern and proper skip pattern
      --           return ([[\<%s\w*\>]]):format(pattern), ([[\<%s]]):format(pattern)
      --         end,
      --       },
      --       -- select the range
      --       jump = { pos = 'range' },
      --     })
      --   end,
      --   mode = { 'x', 'n' },
      -- },
      -- Jump to a line
      -- {
      --   '<leader><leader>l',
      --   function()
      --     require('flash').jump({
      --       search = { mode = 'search', max_length = 0 },
      --       label = { after = { 0, 0 } },
      --       pattern = '^',
      --     })
      --   end,
      --   mode = { 'x', 'n' },
      --   desc = 'Jump to line',
      -- },
      -- Hop
      -- {
      --   '<leader><leader>h',
      --   function()
      --     local Flash = require('flash')
      --
      --     ---@param opts Flash.Format
      --     local function format(opts)
      --       -- always show first and second label
      --       return {
      --         { opts.match.label1, 'FlashMatch' },
      --         { opts.match.label2, 'FlashLabel' },
      --       }
      --     end
      --
      --     Flash.jump({
      --       search = { mode = 'search' },
      --       label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
      --       pattern = [[\<]],
      --       action = function(match, state)
      --         state:hide()
      --         Flash.jump({
      --           search = { max_length = 0 },
      --           highlight = { matches = false },
      --           label = { format = format },
      --           matcher = function(win)
      --             -- limit matches to the current label
      --             return vim.tbl_filter(function(m)
      --               return m.label == match.label and m.win == win
      --             end, state.results)
      --           end,
      --           labeler = function(matches)
      --             for _, m in ipairs(matches) do
      --               m.label = m.label2 -- use the second label
      --             end
      --           end,
      --         })
      --       end,
      --       labeler = function(matches, state)
      --         local labels = state:labels()
      --         for m, match in ipairs(matches) do
      --           match.label1 = labels[math.floor((m - 1) / #labels) + 1]
      --           match.label2 = labels[(m - 1) % #labels + 1]
      --           match.label = match.label1
      --         end
      --       end,
      --     })
      --   end,
      --   mode = { 'x', 'n' },
      --   desc = 'Hop',
      -- },
    },
  },
}
