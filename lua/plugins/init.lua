local api = vim.api
-- Initialize
local use = require('strive').use

--- NOTE: plugin -------------
--- new | SPEC | new plugin instance
---
--- get_path | string || the plugin installation path
--- is_installed | | bool | Check if plugin is installed
--- load_opts
--- load_scripts | | void | return a promise
--- load | do_action, callback | void | Load a plugin and its dependencies
--- on | {}: events | | Set up lazy loading on specific events
--- ft | {}: filetypes | | Set up lazy loading for specific filetypes
--- cmd | {}: commands | | Set up lazy loading for specific commands
--- keys | {}: mappings | | Set up lazy loading for specific keymaps
--- cond | function | | set a condition to load plugin
--- load_path | string: path | | Mark a plugin as dev
--- setup | {} | | Set plugin configuration options
--- init | function | | runs BEFORE the plugin runs
--- config | function | | runs AFTER the plugin loads
--- after | function | | runs after dependencies load
--- theme | ?name | | Set plugin as a theme
--- call_setup | | |
--- run | string | | executed action on build
--- depends | string or {} | |  Add dependency to a plugin
--- install | | promise |  install the plugin
--- has_update | | boolean | if has update
--- update
--- install_with_retry

-- NOTE: Last Event
-- StriveDone

--- NOTE: UI
-- use('echasnovski/mini.starter'):init(function()vim.print('init starter')end):setup({})

use 'echasnovski/mini.starter'
  :config(require('plugins.configs.mini-starter-c'))
  :cond(function()
    return vim.fn.argc() == 0
    and api.nvim_buf_line_count(0) == 0
    and api.nvim_buf_get_name(0) == ''
  end)
  :load() -- Load no lazy

-- use 'folke/which-key.nvim'

use 'folke/tokyonight.nvim'
  :theme('tokyonight-night')

