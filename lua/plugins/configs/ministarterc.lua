return function()

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
  local fsessions = function(n)
    local msessions = require('mini.sessions')
    local items = vim.tbl_keys(msessions.detected)
    local session_name = 'Mini Sessions'

    if vim.tbl_count(items) == 0 then
      return {
        { name = [[There are no detected sessions]], action = '', section = session_name },
      }
    end

    local fitems = {}
    local homed = vim.fn.expand('~')
    for indx, el in ipairs(items) do
      local dir, branch = unpack(vim.split(el, '%%', { plain = true }))
      local name = dir:gsub('%%', '/'):gsub(homed, '~')
      branch = branch and ' [' .. branch:gsub('%%', '/') .. ']' or ''
      table.insert(fitems, {
        name = name .. branch,
        action = function()
          msessions.read(el)
        end,
        section = session_name,
      })

      if indx == n then
        break
      end
    end
    return fitems
  end

  local starter = require('mini.starter')
  starter.setup({
    header = 'PERFECTO',
    footer = '---',
    evaluate_single = true,
    items = {
      -- starter.sections.telescope(),
      starter.sections.builtin_actions(),
      --
      {
        { name = 'Files', action = [[Pick files]], section = 'CMD' },
        { name = 'Old files', action = [[Pick oldfiles]], section = 'CMD' },
        -- {name="Old files", action = [[Pick oldfiles]], section="CMD"},
      },
      fsessions(4),
      -- starter.sections.pick(),

      -- starter.sections.recent_files(6, false),
      -- starter.sections.recent_files(6, true),
      --     -- Use this if you set up 'mini.sessions'
      -- starter.sections.sessions(5, true),
    },
    content_hooks = {
      -- starter.gen_hook.padding(2,2),
      starter.gen_hook.adding_bullet(),
      -- starter.gen_hook.adding_bullet('┃ '),
      -- starter.gen_hook.indexing('all', { 'Builtin actions' }),
      -- starter.gen_hook.adding_bullet('├ ', true),
      starter.gen_hook.aligning('center', 'center'),
      -- starter.gen_hook.indexing('all', { 'Builtin actions' }),
      -- starter.gen_hook.padding(3, 2),

      -- starter.gen_hook.adding_bullet('» '),
      -- starter.gen_hook.adding_bullet('░ '),
      -- -- ░ ▒ ▓ » · ■ ├ ╠
      -- starter.gen_hook.aligning('center', 'center'),
      -- starter.gen_hook.adding_bullet(),
      -- starter.gen_hook.aligning('center', 'center'), ------------------------------------ - - - - --- - - - - - - - -- - - -  - - - - -
    },
  })
end
