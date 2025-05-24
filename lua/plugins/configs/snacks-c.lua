return function()
  local opts = {
    animate = { enabled = false },
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = {
      formats = {
        key = function(item)
          return { { '[', hl = 'special' }, { item.key, hl = 'key' }, { ']', hl = 'special' } }
        end,
      },
      sections = {
        { section = 'startup' },
        -- { section = "terminal", cmd = "fortune -s | cowsay", hl = "header", padding = 1, indent = 8 },
        { title = 'MRU', padding = 1 },
        { section = 'recent_files', limit = 5, padding = 1 },
        { title = 'MRU ', file = vim.fn.fnamemodify('.', ':~'), padding = 1 },
        { section = 'recent_files', cwd = true, limit = 5, padding = 1 },
        { title = 'Sessions', padding = 1 },
        { section = 'projects', padding = 1 },
        { title = 'Bookmarks', padding = 1 },
        { section = 'keys' },
      },
    },
    debug = { enabled = false },
    dim = { enabled = false },
    explorer = { enabled = true },
    git = { enabled = true },
    gitbrowse = { enabled = false },
    indent = {
      indent = {
        priority = 1,
        enabled = true, -- enable indent guides
        char = '│',
        only_scope = false, -- only show indent guides of the scope
        only_current = false, -- only show indent guides in the current window
        hl = 'SnacksIndent', ---@type string|string[] hl groups for indent guides
        -- can be a list of hl groups to cycle through
      },
      -- animate scopes. Enabled by default for Neovim >= 0.10
      -- Works on older versions but has to trigger redraws during animation.
      ---@class snacks.indent.animate: snacks.animate.Config
      ---@field enabled? boolean
      --- * out: animate outwards from the cursor
      --- * up: animate upwards from the cursor
      --- * down: animate downwards from the cursor
      --- * up_down: animate up or down based on the cursor position
      ---@field style? "out"|"up_down"|"down"|"up"
      animate = {
        enabled = false,
      },
      ---@class snacks.indent.Scope.Config: snacks.scope.Config
      scope = {
        enabled = true, -- enable highlighting the current scope
        priority = 200,
        char = '│',
        underline = false, -- underline the start of the scope
        only_current = false, -- only show scope in the current window
        hl = 'SnacksIndentScope', ---@type string|string[] hl group for scopes
      },
      chunk = {
        -- when enabled, scopes will be rendered as chunks, except for the
        -- top-level scope which will be rendered as a scope.
        enabled = true,
        -- only show chunk scopes in the current window
        only_current = false,
        priority = 200,
        hl = 'SnacksIndentChunk', ---@type string|string[] hl group for chunk scopes
        char = {
          corner_top = '┌',
          corner_bottom = '└',
          -- corner_top = "╭",
          -- corner_bottom = "╰",
          horizontal = '─',
          vertical = '│',
          arrow = '>',
        },
      },
      -- filter for buffers to enable indent guides
      filter = function(buf)
        return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ''
      end,
    },
    input = { enabled = true },

    notifier = {},

    -- bigfile = { enabled = true },
    -- explorer = { enabled = true },
    -- indent = { enabled = false },
    -- input = { enabled = true },
    -- picker = { enabled = true },
    -- notifier = { enabled = true },
    -- quickfile = { enabled = true },
    -- scope = { enabled = true },
    -- scroll = { enabled = true },
    -- statuscolumn = { enabled = true },
    -- words = { enabled = true },
  }
end
