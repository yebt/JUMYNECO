local uv = vim.uv
local strive_path = vim.fn.stdpath('data') .. '/site/pack/strive/start/strive'

local installed = (uv.fs_stat(strive_path) or {}).type == 'directory'

--- CONFIGS FOR Strive
-- Set custom configuration before loading
vim.g.strive_auto_install = true        -- Auto-install plugins on startup
-- vim.g.strive_max_concurrent_tasks = 8   -- Limit concurrent operations
vim.g.strive_log_level = 'debug'         -- Set logging level (debug, info, warn, error)
-- vim.g.strive_git_timeout = 60000        -- Git operation timeout in ms
-- vim.g.strive_git_depth = 1              -- Git clone depth
-- vim.g.strive_install_with_retry = false -- Retry failed installations

--- LOADING
async(function()
  if not installed then
    local result =
      try_await(asystem({ 'git', 'clone', 'https://github.com/nvimdev/strive', strive_path }, {
        timeout = 5000,
        stderr = function(_, data)
          if data then
            vim.schedule(function()
              vim.notify(data, vim.log.levels.INFO)
            end)
          end
        end,
      }))

    if not result.success then
      return vim.notify('Failed install strive', vim.log.levels.ERROR)
    end
    vim.notify('Strive installed success', vim.log.levels.INFO)
  end

  vim.o.rtp = strive_path .. ',' .. vim.o.rtp

  -- local use = require('strive').use

  require('plugins.init')

end)()

