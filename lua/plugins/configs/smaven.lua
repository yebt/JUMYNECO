return function()
  local smv = require('supermaven-nvim')
  smv.setup({
    keymaps = {
      accept_suggestion = '<C-j>',
      clear_suggestion = '<C-]>',
      accept_word = '<M-j>',
    },
    ignore_filetypes = {
      'minifiles',
      'minipick',
      'OverseerForm',
      'Overseer*',
    }, -- or { "cpp", }
    color = {
      suggestion_color = '#cdbcde',
      cterm = 244,
    },
    log_level = 'info', -- set to "off" to disable logging completely
    disable_inline_completion = true, -- disables inline completion for use with cmp
    disable_keymaps = false, -- disables built in keymaps for more manual control
    condition = function()
      return false
    end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
    
  })
end
