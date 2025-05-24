function get_package_manager_stats()
  local package_manager_stats = { name = '', count = 0, loaded = 0, time = 0 }
  ---@diagnostic disable-next-line: undefined-global
  if packer_plugins then
    package_manager_stats.name = 'packer'
    ---@diagnostic disable-next-line: undefined-global
    package_manager_stats.count = #vim.tbl_keys(packer_plugins)
  end
  local status, lazy = pcall(require, 'lazy')
  if status then
    package_manager_stats.name = 'lazy'
    local stats = lazy.stats()
    package_manager_stats.loaded = stats.loaded
    package_manager_stats.count = stats.count
    package_manager_stats.time = stats.startuptime
  end
  local ok = pcall(require, 'strive')
  if ok then
    package_manager_stats.name = 'strive'
    package_manager_stats.loaded = vim.g.strive_loaded
    package_manager_stats.time = vim.g.strive_startup_time
    package_manager_stats.count = vim.g.strive_count
  end
  return package_manager_stats
end

function make_footer()
  local package_manager_stats = get_package_manager_stats()
  local lines = {}

  if package_manager_stats.name == 'lazy' then
    lines = {
      '',
      'Startuptime: ' .. package_manager_stats.time .. ' ms',
      'Plugins: ' .. package_manager_stats.loaded .. ' loaded / ' .. package_manager_stats.count .. ' installed',
    }
  elseif package_manager_stats.name == 'strive' then
    lines = {
      '',
      'Startuptime: ' .. (package_manager_stats.time or '···') .. ' ms',
      'Plugins: ' .. package_manager_stats.loaded .. ' loaded / ' .. package_manager_stats.count .. ' installed',
    }
  else
    lines = {
      '',
      'neovim loaded ' .. package_manager_stats.count .. ' plugins',
    }
  end

  if #lines > 0 then
    return table.concat(lines, '\n')
  end
  return '···'
end

return function()
  local starter = require('mini.starter')
  --- FOOT
  local footer_func = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = { 'StriveDone', 'LazyVimStarted' },
      callback = function()
        MiniStarter.refresh()
      end,
    })
    return make_footer()
  end

  ---
  local bnr = {
    -- " ▄   ▄▄▄ ▄▄▄ ▄ ▄  ▄▄ ",
    -- " █▄▄ █▄█  █  █▄█ ▄█  ",

    '█▄▄ ███ ▀█▀ █▄█ ▄█▀',
  }

  --
  starter.setup({
    header = table.concat(bnr, '\n'),
    autoopen = true,
    evaluate_single = true,
    footer = footer_func,

    items = {
      starter.sections.pick(),
      starter.sections.recent_files(5, false, false),
      starter.sections.builtin_actions(),
    },

    content_hooks = {
      starter.gen_hook.adding_bullet(),
      starter.gen_hook.aligning('center', 'center'),

      -- starter.gen_hook.indexing('all', { 'Builtin actions' }),
      -- starter.gen_hook.padding(3, 2),

      -- starter.gen_hook.adding_bullet(),
      -- -- starter.gen_hook.indexing('all', { 'Builtin actions' }),
      -- -- starter.gen_hook.padding(3, 2),
      -- -- starter.gen_hook.indexing('all', { 'Builtin actions' }),
    },
  })
end
