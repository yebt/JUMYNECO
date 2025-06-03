local au = vim.api.nvim_create_autocmd
local api = vim.api
local g = vim.g
local group = vim.api.nvim_create_augroup('statusline.actions', { clear = true })

local padding = '%#Normal# %0*' -- xpadding
local separator = '%=' -- separator
local nrml = '%#Normal# %*'

-----------------------
------- Set highlight
-----------------------

local function set_hl_status()
  local hl = vim.api.nvim_set_hl

  hl(0, 'stlSeparator', { fg = '#888888' })
  hl(0, 'stlEncoding', { fg = '#ffaa00' })
  hl(0, 'stlInfo', { fg = '#55aaee' })
  hl(0, 'stlGit', { fg = '#ff6c6b', bold = true })
  hl(0, 'stlGitR', { fg = '#ff6c6b', reverse = true, bold = true })
  hl(0, 'stlArrow', { fg = '#ffaaee' })
  hl(0, 'stlFilename', { fg = '#abb2bf', bold = true })
  hl(0, 'stlFilenameR', { fg = '#abb2bf', reverse = true, bold = true })

  hl(0, 'stlLSP', { fg = '#6290C8', italic = true })

  hl(0, 'stlModeNormal', { fg = '#98c379', bold = true })
  hl(0, 'stlModeInsert', { fg = '#61afef', bold = true })
  hl(0, 'stlModeVisual', { fg = '#c678dd', bold = true })
  hl(0, 'stlModeNormalR', { fg = '#98c379', bold = true, reverse = true })
  hl(0, 'stlModeInsertR', { fg = '#61afef', bold = true, reverse = true })
  hl(0, 'stlModeVisualR', { fg = '#c678dd', bold = true, reverse = true })
  ---
end

au('ColorScheme', {
  callback = set_hl_status,
})

-----------------------
------- MODE
-----------------------
local mode_alias = {
  --Normal
  ['n'] = 'nor',
  ['v'] = 'vis',
  ['V'] = 'v-l',
  ['\x16'] = 'v-b',
  ['s'] = 's',
  ['S'] = 's-l',
  ['\x13'] = 's-b',
  ['i'] = 'ins',
  ['R'] = 'rep',
  ['Rv'] = 'v-r',
  ['c'] = 'cmd',
  ['cv'] = 'exe',
  ['ce'] = 'exe',
  ['!'] = 'shl',
  ['t'] = 'term',
}

local function ml_mode()
  local mode = api.nvim_get_mode().mode
  local m = mode_alias[mode] or mode_alias[string.sub(mode, 1, 1)] or 'UNK'
  g.stl_mod_str = m:sub(1, 3):upper()
end

local mode_map = {
  n = { 'NOR', 'stlModeNormal' },
  i = { 'INS', 'stlModeInsert' },
  v = { 'VIS', 'stlModeVisual' },
  V = { 'V-L', 'stlModeVisual' },
  [''] = { 'V-B', 'stlModeVisual' },
  c = { 'CMD', 'stlModeCommand' },
  R = { 'REP', 'stlModeReplace' },
  t = { 'TER', 'stlModeTerminal' },
}

local function color_mode()
  local mode = vim.api.nvim_get_mode().mode
  local data = mode_map[mode] or { mode, 'stlMode' }
  g.stl_mod_str = ('%%#%s# %s %%*'):format(data[2], data[1])
end

-- mode to show
au({ 'ModeChanged' }, {
  callback = color_mode,
})

-----------------------
------- Startup Time
-----------------------

g.stl_startup = ''

local function get_startup_time()
  local ok, lz = pcall(require, 'lazy')
  if ok then
    local num = lz.stats().startuptime
    g.stl_startup = ' '.. string.format("%.2f", num)
  end
end

au({ 'VimEnter', 'User'}, {
  pattern = { 'PostVeryLazy','VeryLazy'  },
  callback = get_startup_time,
})

-----------------------
------- BRANCH
-----------------------

g.current_git_branch = ''

local function update_git_branch()
  async(function()
    local result = try_await(asystem({ 'git', 'rev-parse', '--abbrev-ref', 'HEAD' }, { text = true }))
    if result.success then
      local branch = vim.trim(result.value.stdout)
      g.current_git_branch = '%#stlGit#  %#stlGitR#[ ' .. branch .. ' ]'
      vim.api.nvim__redraw({ statusline = true })
    end
  end)()
end

vim.defer_fn(update_git_branch, 100) -- Llama una vez al inicio

-----------------------
------- LSP Status
-----------------------

local function get_actual_clients()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients > 0 then
    local names = {}
    for _, client in ipairs(clients) do
      table.insert(names, client.name)
    end
    local lst = table.concat(names, ',')
    vim.b.stl_lsp_clients = ('%#stlLSP#󰿘 [%s]'):format(lst)
  else
    vim.b.stl_lsp_clients = ''
  end
end

vim.api.nvim_create_autocmd({ 'LspAttach', 'LspDetach', 'LspProgress' }, {
  callback = get_actual_clients,
})

-----------------------
------- COMPS
-----------------------

-- paps
local components = {
  nrml,
  -- '%g.current_git_branch
  [[%{%get(g:,'current_git_branch','')%}]],
  -- '%f',
  separator,
  -- LSP
  [[%{%get(b:,'stl_lsp_clients','')%}]],
  --
  separator,
  -- '%{mode()}',
  '%<',
  [[%{%get(g:,'stl_startup','')%}]],
  ' ',
  ' %p%% (%l,%c%V)',
  [[%{%get(g:,'stl_mod_str','')%}]],
  nrml,
}

au({ 'VimEnter', 'User' }, {
  pattern = 'PostVeryLazy',
  once = true,
  callback = function()
    set_hl_status()
    color_mode()
  end,
})

vim.opt.statusline = table.concat(components, '%#Statusline#')

--- set the winbar
--- ===========================================================
-- function l_path()
--   local actual_filetype = vim.bo.filetype
--   local full_path = vim.api.nvim_buf_get_name(0)
--   local prefix = " >> %#Comment#%<"
--
--   -- Empty filetypes
--   local fts = {
--     ['snacks_dashboard'] = true,
--   }
--   if fts[actual_filetype] then return "%#Normal#" end
--
--   -- Special mods
--   local mods = {
--     [''] = '[NOPE]',
--     ['Starter'] = '[STRTR]',
--   }
--   local smod  = mods[full_path] or nil
--   if smod then return prefix .. "%#Constant#".. smod end
--
--   -- Specific complex appariences
--   local cwd = vim.fn.getcwd()
--   local relative_path = vim.fn.fnamemodify(full_path, ':~:.')
--   local base = vim.fn.fnamemodify(relative_path, ':h') -- head (directorio)
--   local tail = vim.fn.fnamemodify(relative_path, ':t') -- tail (archivo)
--
--   return prefix ..base.. "/%#Constant#" .. tail .. "%#ModeMsg#%{%(bufname() !=# '' ? ' %y' : '')%}%* %H%W%M%R%#Normal#%=%f"
-- end
-- vim.opt.winbar = [[%{%v:lua.l_path()%}]]
-- vim.opt.winbar = [[ >> %#Comment#%<%{expand("%:h")}%{%(bufname() !=# '' ? '/' : '')%}%#Constant#%t%#ModeMsg#%{%(bufname() !=# '' ? ' %y' : '')%}%* %H%W%M%R%#Normal#]],
-- vim.opt.winbar = [[ >> %#Comment#%<%{expand("%:~:.:h")}%{%(bufname() !=# '' ? '/' : '')%}%#Constant#%t%#ModeMsg#%{%(bufname() !=# '' ? ' %y' : '')%}%* %H%W%M%R%#Normal#]]

