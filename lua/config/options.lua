local vopt = vim.opt
local vg = vim.g
local vapi = vim.api
local spf = vim.fs.joinpath(vim.fn.stdpath('config'), 'spell')

--- OPTIONS VAR LOOP
local options = {
  -- Cursor
  cursorline = true, -- show cursor line highlights:
  guicursor = 'a:block-cursor', -- show the cursor in block in any mode
  virtualedit = 'block', --

  -- Sizes -- Removed cause is used in the toggler map
  winwidth = 140,
  winminwidth = 20,
  winheight=20,
  winminheight = 10,

  -- Tab
  expandtab = true, -- convert tabs  in spaces
  shiftwidth = 4,
  tabstop = 4,
  softtabstop = 4,

  -- Indentation
  copyindent = true,
  preserveindent = true,
  smartindent = true,
  smarttab = true,
  autoindent = true,

  -- Wrap
  wrap = false,
  linebreak = true,
  breakindentopt = 'shift:2,min:20', --"min:40, shift:0,sbr"
  breakindent = true,
  showbreak = '↳ ',

  -- File
  -- autowrite = true,
  autoread = true,
  backup = false,
  writebackup = false,
  backupdir = vim.fs.joinpath(vim.fn.stdpath('config'), '.backups'),
  swapfile = false,
  undofile = true,

  -- Spell
  spelllang = 'en,es',
  spelloptions = 'camel',
  spellfile = {
    vim.fs.joinpath(vim.fn.stdpath('config'), 'spell/en.utf-8.add'),
    vim.fs.joinpath(vim.fn.stdpath('config'), 'spell/es.utf-8.add'),
  },

  -- View
  background = 'dark',
  termguicolors = true,
  fillchars = {
    diff = '╱',
    -- 
    -- 
    foldclose = '',
    foldopen = '',
    -- foldsep = "│",
    foldsep = '▏',
    -- diff = "",
  },

  ruler = true,
  showtabline = 1, -- always
  tabpagemax = 15,
  -- tabline='%0*%#TabLine#%#TabLineSel#> %<%f %h%m%r %0*'
  -- tabline='%#TabLine# %#TabLineSel#> %<%f %#WarningMsg#%h%m%r %#TabLineFill#',
  laststatus = 3,
  -- winbar = " %<%f %h%m%r%w%y%#Normal#",
  -- statuscolumn
  -- statusline
  -- statusline = " ",

  -- Split
  splitbelow = true,
  splitright = true,
  splitkeep = 'screen',
  inccommand = 'split',

  -- CMD
  cmdheight = 1,
  -- cmdwinheight = 8,
  showcmd = true,
  showmode = false,

  -- -- Short
  shortmess = {

    --- DEFAULT: ltToOCF
    l = true, --- short lines and bytes
    t = true, --- Truncate file message at the start if is so long
    T = true, --- Truncate all messges
    o = true, --- Overwtite message for writting file by subsequence
    O = true, ---
    -- C = true, ---  dont give messages while scaning for ins completion
    F = true, --- Don't given the file info when editing a file like silent
    m = true, --- short modified message
    I = true, -- not get intro message


    -- a = true, -- abbreviate all messages
    -- o = true, -- overwite write message
    -- O = true, --
    -- T = true, -- trunkate messages ...
    -- F = true,
    -- c = true, -- now show autocmpletion print
  },

   -- Columns
   number = true,
   relativenumber = true,

   -- Fold
   foldenable = true,
   foldlevelstart = 99,
   foldmethod = 'indent', -- marker, indent
   foldcolumn = '1',

   -- Sign
   -- signcolumn = 'yes',
   -- signcolumn = 'yes:1',
   -- signcolumn = 'auto:4',
   -- signcolumn = 'auto:2',
   signcolumn = 'yes:2',

   -- Text
   textwidth = 100,
   -- colorcolumn = '100',

   -- Format
   formatoptions = {
     t = true, -- Autowrap textwidth
     c = true, -- Autowrapp comments with textwidth
     q = true, -- Allow formating comments with gq
     j = true, -- Where it makes sense, remove a comment leader when joining lines.
   },

   list = true,
   -- listchars = 'tab:»·,nbsp:+,trail:·,vextends:→,precedes:←',
   listchars = {
     -- eol='¶',
     -- eol='¬',
     -- eol = '↴',
     -- tab='»·',
     tab = '⤚·',
     -- tab='⇤–⇥',
     -- tab='├→',
     -- tab='│ ',
     -- tab='>·',
     nbsp = '+',
     -- lead='·',
     trail = '·',
     extends = '→',
     -- precedes = '←',
   },

   -- Conceal
   concealcursor = 'nc',
   conceallevel = 2,

   -- Buffer
   hidden = true,
   magic = true,

   -- Search
   ignorecase = true,
   wildignorecase = true, -- ignorecase files
   smartcase = true,
   incsearch = true,

   -- Dirs
   -- autochdir=true, -- change the dir to file dir

   -- Editing
   backspace = 'indent,eol,start,nostop',
   diffopt = {
     'filler', -- sync text content
     -- "horizontal", -- use horizontal views -
     'closeoff', -- off diff on just 1 window
     --"followwrap",
     -- "internal",
     'linematch:60', --
     --  myers      the default algorithm
     -- minimal    spend extra time to generate the
     -- smallest possible diff
     -- patience   patience diff algorithm
     -- histogram  histogram diff algorithm
     -- "algorithm:histogram"
   },

   -- -- Usage
   clipboard = 'unnamed',
   compatible = false,
   whichwrap = 'h,l,<,>,[,],~',
   -- confirm = true,
   cpoptions = {
     a = true, -- change windows name with the read comman file name
     A = true, -- change windows name with the write comman file name
     B = true, -- No special meaning of backslash in the maps
     c = true, -- Searching continues at the end of any match at the cursor
     e = true, -- Add CR to last line wjen executing a register with ":@r"
     F = true, -- When included, a ":write" command a filename set filename to buffer
     s = true, -- Set the buffer options for first time
     --
     -- n = true, -- use number for wrap number
     ['_'] = true, -- not cut the white space nex to word when press cw
   },
   -- sessionoptions = 'buffers,curdir,winsize',
   sessionoptions = {
     'buffers',
     'curdir',
     'tabpages',
     'winpos',
     'winsize',
     -- 'folds',
   },

   viewoptions = 'folds,cursor',

   -- Time
   timeout = true, -- timeout for maps
   ttimeout = true, --timeout for tui like ESC
   timeoutlen = 500,
   ttimeoutlen = 10,
   updatetime = 500, -- 4000 -- cursor hold event
   -- redrawtime = 1500, -- 2000 -- time for redraw by hlsearch, incoomand and match

   -- Scroll
   scroll = 4, -- quentity of lines scrolled
   scrolloff = 2, -- lines like a gap when scroll, if is 0, the scroll occourse when cursor es in the limit
   -- sidescrolloff = 5,

   -- Completionos
   complete = '.,k,w,b,u,t',
   completeopt = {
     'menu',
     'menuone',
     'preview', -- show extra info in preview windows -- not complatible with preview
     -- 'popup', -- show extra info in a popup winndow
     --- Sometimes i need insert the selected options when i trigger it manually
     -- 'noinsert',
     -- 'noselect',
     -- 'fuzzy' -- is not in nvim 10
    'popup'
   },
   -- pumheight = 15,

  -- adds actions
  modeline = true,
  exrc = true,
}

--- VARS GLOBAL LOOP
local globals = {
  loaded_perl_provider = 0,
  loaded_ruby_provider = 0,
  loaded_node_provider = 0,
  loaded_python_provider = 0,
  loaded_python3_provider = 0,
  --
  -- netrw_browse_split = 4,
  netrw_banner = 0,
  netrw_use_errorwindow = 0,
  netrw_windize = 35,
  netrw_keepdir = 0,
}

--- Load setter
for key, valor in pairs(options) do
  vopt[key] = valor
end
for key, valor in pairs(globals) do
  vg[key] = valor
end

--if vim.fn.executable('rg') == 1 then
vopt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
vopt.grepprg = 'rg --vimgrep --no-heading --smart-case'
