return function()

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
      -- fsessions(4),
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
