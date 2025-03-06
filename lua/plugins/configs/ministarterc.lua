return function()
  local unpack =  table.unpack or unpack
  local uv = vim.uv or vim.loop

  --- ST
  -- ⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⣄⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀
  -- ⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⢰⣿⣦⡀⡀⡀⢀⡄⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀
  -- ⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡄⡀⠂⢀⣿⣿⣿⣧⡀⢠⣾⡇⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀
  -- ⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⣬⡄⠠⣤⣼⣿⣿⣿⡿⠛⠛⠛⠓⠠⡀⢀⣀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀
  -- ⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⣴⣿⣿⣿⣿⣿⣿⣿⣿⠷⡀⡀⡀⡀⡀⡀⣀⣀⡉⢷⣄⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀
  -- ⡀⡀⡀⡀⡀⡀⡀⡀⣶⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⡀⡀⡀⠐⠶⢿⣿⣿⣿⡀⠉⠒⠤⣄⣀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀
  -- ⡀⡀⡀⡀⡀⡀⡀⡀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣤⣤⣤⠶⣤⣄⠙⠛⠟⡀⡀⡀⡀⡀⠈⠉⠹⣷⣶⣶⡄⡀⡀⡀⡀⡀⡀⡀
  -- ⡀⡀⡀⡀⡀⡀⡀⡀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡅⡀⠱⡿⣧⡀⡀⡀⡀⠘⡀⠘⠤⢀⡀⠙⠹⣿⠁⡀⡀⡀⡀⡀⡀⡀
  -- ⡀⡀⡀⡀⡀⡀⡀⡀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣀⡀⢁⡀⠳⠒⠒⠶⠒⠤⠿⠶⡺⡀⠎⢲⡼⡀⡀⡀⡀⡀⡀⡀⡀
  -- ⡀⡀⡀⡀⡀⡀⡀⡀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣤⣄⣀⣀⣀⣀⣄⣀⣠⡤⠷⠚⠛⡀⡀⡀⡀⡀⡀⡀⡀⡀
  -- ⡀⡀⡀⡀⡀⡀⡀⡀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠋⠉⠉⠉⠛⠋⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀
  -- ⡀⡀⡀⡀⡀⡀⡀⡀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡛⠁⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀
  -- ⡀⡀⡀⡀⡀⡀⡀⡀⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢿⢿⣿⣟⡁⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀
  -- ⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀

  --- FSessions.
  local fsessions = function(n, recent)
    recent = recent or false

    -- local blockName = 'File Mini Sessions'
    local blockName = 'F Sessions'
    local fsessions = {}

    local msns = require('mini.sessions')
    local detected_session = msns.detected

    if vim.tbl_count(detected_session) == 0 then
      return {
        { name = [[There are no detected sessions]], action = '', section = blockName },
      }
    end

    local home_dir = vim.fn.expand('~'):gsub('%-', '%%%-')

    --- Replacer
    local function replace_alias(singlePath)
      local aliases = {
        ['~/Develop/repositories'] = '@repositories',
        ['~/Develop/work'] = '@work',
        ['~/Develop'] = '@Develop',
        ['~/.config'] = '@config',
      }
      table.sort(aliases, function(a, b)
        return #a > #b
      end)
      local repcr = nil
      local als = nil
      for path, alias in pairs(aliases) do
        if string.find(singlePath, path, 1, true) then
          if (not repcr) or (#repcr < #path) then
            repcr = path
            als = alias
          end
          -- break -- Si solo se quiere reemplazar el primer alias que coincida
        end
      end

      if repcr and als then
        singlePath = string.gsub(singlePath, repcr, als)
      end
      singlePath = singlePath:gsub('/[%w%-]*%)$', '/)')
      return singlePath
    end

    local inx = 0
    for session_name, session in pairs(detected_session) do
      inx = inx + 1
      -- local dir, branch = table.unpack(vim.split(session_name, '%%', { plain = true }))
      local dir, branch = unpack(vim.split(session_name, '%%', { plain = true }))
      local name = dir:gsub('%%', '/'):gsub(home_dir, '~')
      name = replace_alias(name)
      branch = branch and ' [' .. branch:gsub('%%', '/') .. ']' or ''
      local sname = name .. branch

      table.insert(fsessions, {
        _session = session,
        name = sname,
        action = function()
          msns.read(session_name)
        end,
        section = blockName,
      })

      -- if n <= inx then
      --   break
      -- end
    end

    if recent then
      local sort_fun = function(a, b)
        local a_time = a._session.type == 'local' and math.huge or a._session.modify_time
        local b_time = b._session.type == 'local' and math.huge or b._session.modify_time
        return a_time > b_time
      end
      table.sort(fsessions, sort_fun)
    end

    -- return fsessions
    return vim.tbl_map(function(x)
      x._session = nil
      return x
    end, vim.list_slice(fsessions, 1, n))

    --
    -- for session_name, session in pairs(session_items) do
    --   local dir, branch = table.unpack(vim.split(session_name, '%%', { plain = true }))
    --   local name = dir:gsub('%%', '/'):gsub(home_dir, '~')
    --   name = replace_alias(name)
    --   branch = branch and ' [' .. branch:gsub('%%', '/') .. ']' or ''
    --   local sname = name .. branch
    --
    --   table.insert(render_session_items, {
    --     _session = session,
    --     name = session_name,
    --     action = function()
    --       msns.read(session_name)
    --     end,
    --     section = blockName,
    --   })
    -- end

    -- for indx, el in ipairs(items) do
    --   local dir, branch = table.unpack(vim.split(el, '%%', { plain = true }))
    --   local name = dir:gsub('%%', '/'):gsub(homed, '~')
    --   branch = branch and ' [' .. branch:gsub('%%', '/') .. ']' or ''
    --   table.insert(fitems, {
    --     name = name .. branch,
    --     action = function()
    --       msessions.read(el)
    --     end,
    --     section = session_name,
    --   })
    --
    --   if indx == n then
    --     break
    --   end
    -- end
    -- if recent
    -- return session_items
  end

  --- Starter
  local starter = require('mini.starter')

  --- Load footer

  vim.api.nvim_create_autocmd('User', {
    once = true,
    -- pattern = { 'LazyVimStarted', 'VeryLazy' },
    pattern = { 'VeryLazy' },
    callback = function()
      local stats = require('lazy').stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      vim.g.lazy_ms = ms
      pcall(starter.refresh)
    end,
  })

  local foot = function()
    local stats = require('lazy').stats()
    if vim.g.lazy_ms then
      local ms = vim.g.lazy_ms

      local lines = {
        'Loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms'
      }
      -- local status = require('lazy.status')
      --   vim.notify(vim.inspect(status.has_updates()))
      --   if status.has_updates() then
      --     table.insert(lines, 'Updates available')
      --   end
      return table.concat(lines, ' ')
    end
    return '...'
  end

  starter.setup({
    header = '> W4L0D3V',
    -- footer = '---',
    footer = foot,
    evaluate_single = true,
    items = {
      -- starter.sections.telescope(),
      starter.sections.builtin_actions(),
      --
      {
        {
          name = 'MFiles',
          action = [[Pick files]],
          section = 'Selectors',
        },
        {
          name = 'MOld files',
          action = [[Pick oldfiles]],
          section = 'Selectors',
        },
        {
          name = 'MSessions',
          action = [[Pick sessions]],
          section = 'Selectors',
        },
        {
          name = 'Live grep fzf',
          action = [[FzfLua live_grep]],
          section = 'Selectors',
        },
        {
          name = 'FzfLua',
          action = [[FzfLua]],
          section = 'Selectors',
        },
        -- {name="Old files", action = [[Pick oldfiles]], section="CMD"},
      },
      -- starter.sections.telescope(),
      --
      -- starter.sections.recent_files(5, false),
      -- starter.sections.recent_files(5, true),
      -- starter.sections.pick(),
      fsessions(5, true),

      -- starter.sections.recent_files(6, false),
      -- starter.sections.recent_files(6, true),
      --     -- Use this if you set up 'mini.sessions'
      -- starter.sections.sessions(5, true),
    },
    content_hooks = {
      -- starter.gen_hook.padding(2,2),
      -- starter.gen_hook.adding_bullet('┃ '),
      -- starter.gen_hook.indexing('all', { 'Builtin actions' }),
      -- starter.gen_hook.adding_bullet('├ ', true),
      -- starter.gen_hook.padding(3, 2),
      --
      -- starter.gen_hook.aligning('center', 'center'),

      -- starter.gen_hook.adding_bullet(),
      -- starter.gen_hook.indexing('all', { 'Builtin actions', 'Mini Sessions','CMD' }),
      -- starter.gen_hook.padding(3, 2),

      starter.gen_hook.adding_bullet(),
      starter.gen_hook.indexing('all', {
        'Builtin actions',
        'Mini Sessions',
        'F Sessions',
        'CMD',
      }),
      starter.gen_hook.aligning('center', 'center'),

      -- starter.gen_hook.adding_bullet('» '),
      -- starter.gen_hook.adding_bullet('░ '),
      -- -- ░ ▒ ▓ » · ■ ├ ╠
      -- starter.gen_hook.aligning('center', 'center'),
      -- starter.gen_hook.adding_bullet(),
      -- starter.gen_hook.aligning('center', 'center'), ------------------------------------ - - - - --- - - - - - - - -- - - -  - - - - -
    },
  })
end
