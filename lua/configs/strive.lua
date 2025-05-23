local strive_path = vim.fn.stdpath('data') .. '/site/pack/strive/start/strive'
if not vim.uv.fs_stat(strive_path) then
  vim.fn.system({
    'git',
    'clone',
    '--depth=1',
    'https://github.com/nvimdev/strive',
    strive_path
  })

  vim.o.rtp = strive_path .. ',' .. vim.o.rtp
end


require('plugins')
