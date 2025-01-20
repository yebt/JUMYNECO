return function()
  local miniSnips = require('mini.snippets')

  local match_strict = function(snips)
    -- Do not match with whitespace to cursor's left
    return MiniSnippets.default_match(snips, { pattern_fuzzy = '%S+' })
  end
  local expand_or_jump = function()
    local can_expand = #MiniSnippets.expand({ insert = false }) > 0
    if can_expand then
      vim.schedule(MiniSnippets.expand)
      return ''
    end
    local is_active = MiniSnippets.session.get() ~= nil
    if is_active then
      MiniSnippets.session.jump('next')
      return ''
    end
    return '\t'
  end

  local jump_prev = function()
    MiniSnippets.session.jump('prev')
  end
  vim.keymap.set('i', '<Tab>', expand_or_jump, { expr = true })
  vim.keymap.set('i', '<S-Tab>', jump_prev)

  miniSnips.setup({
    snippets = {
      -- Load custom file with global snippets first (adjust for Windows)
      miniSnips.gen_loader.from_file('~/.config/nvim/snippets/global.json'),

      -- Load snippets based on current language by reading files from
      -- "snippets/" subdirectories from 'runtimepath' directories.
      miniSnips.gen_loader.from_lang(),
    },
    mappings = {
      -- -- Expand snippet at cursor position. Created globally in Insert mode.
      -- expand = '<C-j>',
      --
      -- -- Interact with default `expand.insert` session.
      -- -- Created for the duration of active session(s)
      -- jump_next = '<C-l>',
      -- jump_prev = '<C-h>',
      -- stop = '<C-c>',

      expand = '',
      jump_next = '',
      jump_prev = '',
    },
    -- Functions describing snippet expansion. If `nil`, default values
    -- are `MiniSnippets.default_<field>()`.
    expand = {
      -- Resolve raw config snippets at context
      prepare = nil,
      -- Match resolved snippets at cursor position
      -- match = nil,
      match = match_strict,
      -- Possibly choose among matched snippets
      select = nil,
      -- Insert selected snippet
      insert = nil,
    },
  })

  --
  -- Stop session immediately after jumping to final tabstop ~
  local fin_stop = function(args)
    if args.data.tabstop_to == '0' then
      MiniSnippets.session.stop()
    end
  end
  local au_opts = { pattern = 'MiniSnippetsSessionJump', callback = fin_stop }
  vim.api.nvim_create_autocmd('User', au_opts)
end
