return function()
  local opts = {
    enable_chat = true,
    enable_cmp_source = false,
    virtual_text = {
      enabled = true,
      key_bindings = {
        -- Accept the current completion.
        accept = '<C-j>',
        -- Accept the next word.
        accept_word = '<M-J>',
        -- Accept the next line.
        accept_line = false,
        -- Clear the virtual text.
        clear = false,
        -- Cycle to the next completion.
        next = '<M-]>',
        -- Cycle to the previous completion.
        prev = '<M-[>',
      },
    },
  }
  require('codeium').setup(opts)
end
