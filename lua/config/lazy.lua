-- Bootstrap lazy.nvim

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.notify('No lazy.nvim plugin manager, installing ...', vim.log.levels.WARM)
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out,                            'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
  vim.notify('Done')
end
vim.opt.rtp:prepend(lazypath)

local Event = require('lazy.core.handler.event')

local lazy_file_events = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }
Event.mappings.LazyFile = { id = 'LazyFile', event = lazy_file_events }
Event.mappings['User LazyFile'] = Event.mappings.LazyFile

-- Setup lazy.nvim
require('lazy').setup({
  defaults = {
    lazy = true,
  },
  spec = {
    -- import your plugins
    { import = 'plugins.specs' },
  },
  -- rocks = {
  --   enabled = true,
  --   root = vim.fn.stdpath("data") .. "/lazy-rocks",
  --   server = "https://nvim-neorocks.github.io/rocks-binaries/",
  --   -- use hererocks to install luarocks?
  --   -- set to `nil` to use hererocks when luarocks is not found
  --   -- set to `true` to always use hererocks
  --   -- set to `false` to always use luarocks
  --   hererocks = nil,
  -- },
  -- dev = {
  --   -- Directory where you store your local plugin projects. If a function is used,
  --   -- the plugin directory (e.g. `~/projects/plugin-name`) must be returned.
  --   ---@type string | fun(plugin: LazyPlugin): string
  --   path = "~/projects",
  --   ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
  --   patterns = {},    -- For example {"folke"}
  --   fallback = false, -- Fallback to git when local plugin doesn't exist
  -- },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    -- unokai
    -- retrobox
    colorscheme = { "unokai" },
  },
  -- Output options for headless mode
  headless = {
    -- show the output from process commands like git
    process = true,
    -- show log messages
    log = true,
    -- show task start/end
    task = true,
    -- use ansi colors
    colors = true,
  },
  checker = {
    -- automatically check for plugin updates
    enabled = false,
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = true,        -- get a notification when new updates are found
    frequency = 3600,     -- check for updates every hour
    check_pinned = false, -- check for pinned packages that can't be updated
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    notify = true, -- get a notification when changes are found
  },
  --
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true,        -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {},          -- add any custom paths here that you want to includes in the rtp
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        -- "editorconfig",
        'gzip',
        'man',
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        'osc52',
        'rplugin',
        'shada',
        'spellfile',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
  profiling = {
    -- Enables extra stats on the debug tab related to the loader cache.
    -- Additionally gathers stats about all package.loaders
    loader = false,
    -- Track each new require in the Lazy profiling tab
    require = false,
  },

})

vim.keymap.set('n', '<leader>lpp', ':Lazy profile<cr>')
