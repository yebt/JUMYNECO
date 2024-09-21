return function()
  local fzfl = require('fzf-lua')

  fzfl.setup({
    -- 'telescope',
    -- fzf_opts = { ['--layout'] = 'reverse' },
    -- winopts = {
    --   -- preview = { default = 'bat' },
    --   preview = {
    --     hidden = 'nohidden',
    --     vertical = 'down:45%',
    --     horizontal = 'right:50%',
    --     layout = 'flex',
    --     flip_columns = 120,
    --     delay = 10,
    --     winopts = { number = false },
    --   },
    -- },
    keymap = {
      builtin = {
        ['<F1>'] = 'toggle-help',
        ['<F2>'] = 'toggle-fullscreen',
        -- Only valid with the 'builtin' previewer
        ['<F3>'] = 'toggle-preview-wrap',
        ['<F4>'] = 'toggle-preview',
        ['<F5>'] = 'toggle-preview-ccw',
        ['<F6>'] = 'toggle-preview-cw',
        ['<C-d>'] = 'preview-page-down',
        ['<C-u>'] = 'preview-page-up',
        ['<S-left>'] = 'preview-page-reset',
      },
    },
  })

  --
  -- fzf.setup({
  --   'telescope',
  --   winopts = { preview = { default = 'bat' } },
  -- })
end
