---------------------------------------------
--- Lazy.nvim Plugin Manager
---------------------------------------------

--- Bootstrap
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.api.nvim_echo({
    { 'Lazy.nvim is not installed\n', 'WarningMsg' },
    { 'Cloning...' },
  }, true, { verbose = true })
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end

  vim.api.nvim_echo({
    { 'Done', 'DiffAdd' },
  }, true, {})
end
vim.opt.rtp:prepend(lazypath)

--- Map event for usage LazyFile
-- Add support for the LazyFile event

-- vim.api.nvim_create_autocmd("BufReadPost", {
--   once = true,
--   callback = function(event)
--     -- Skip if we already entered vim
--     if vim.v.vim_did_enter == 1 then
--       return
--     end
--
--     -- Try to guess the filetype (may change later on during Neovim startup)
--     local ft = vim.filetype.match({ buf = event.buf })
--     if ft then
--       -- Add treesitter highlights and fallback to syntax
--       local lang = vim.treesitter.language.get_lang(ft)
--       if not (lang and pcall(vim.treesitter.start, event.buf, lang)) then
--         vim.bo[event.buf].syntax = ft
--       end
--
--       -- Trigger early redraw
--       vim.cmd([[redraw]])
--     end
--   end,
-- })

local Event = require('lazy.core.handler.event')

Event.mappings.LazyFile = { id = 'LazyFile', event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' } }
Event.mappings['User LazyFile'] = Event.mappings.LazyFile

--- Setup lazy.nvim
require('lazy').setup({

  defaults = {
    -- Set this to `true` to have all your plugins lazy-loaded by default.
    -- Only do this if you know what you are doing, as it can lead to unexpected behavior.
    lazy = true, -- should plugins be lazy-loaded?
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = nil, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
    -- default `cond` you can use to globally disable a lot of plugins
    -- when running inside vscode for example
    cond = nil, ---@type boolean|fun(self:LazyPlugin):boolean|nil
  },
  rocks = {
    enabled = false,
  },
  spec = {
    { import = 'plugins.specs' },
  },
  ui = {
    -- a number <1 is a percentage., >1 is a fixed size
    size = { width = 0.8, height = 0.8 },
    wrap = true, -- wrap the lines in the ui
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    -- border = { '🭽', '▔', '🭾', '▕', '🭿', '▁', '🭼', '▏' },
  },
  checker = {
    -- automatically check for plugin updates
    enabled = false,
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = true, -- get a notification when new updates are found
    frequency = 3600, -- check for updates every hour
    check_pinned = false, -- check for pinned packages that can't be updated
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    notify = false, -- get a notification when changes are found
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {}, -- add any custom paths here that you want to includes in the rtp
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        'gzip',
        'man',
        'osc52',
        'shada',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
        'nvim',
        'rplugin',
        -- "matchit",
        -- "matchparen",
        -- 'netrwPlugin',
      },
    },
  },
})
