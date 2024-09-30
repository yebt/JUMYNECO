return function()
  local mp = require('mini.pick')
  local opts = {
    delay = {
      -- Delay between forcing asynchronous behavior
      async = 10,
      -- Delay between computation start and visual feedback about it
      busy = 50,
    },
    -- Keys for performing actions. See `:h mp-actions`.
    mappings = {
      caret_left = '<Left>',
      caret_right = '<Right>',

      choose = '<CR>',
      choose_in_split = '<C-s>',
      choose_in_tabpage = '<C-t>',
      choose_in_vsplit = '<C-v>',
      choose_marked = '<M-CR>',

      delete_char = '<BS>',
      delete_char_right = '<Del>',
      delete_left = '<C-u>',
      delete_word = '<C-w>',

      mark = '<C-x>',
      mark_all = '<C-a>',

      move_down = '<C-n>',
      move_start = '<C-g>',
      move_up = '<C-p>',

      paste = '<C-r>',

      refine = '<C-Space>',
      refine_marked = '<M-Space>',

      scroll_down = '<C-f>',
      scroll_left = '<C-h>',
      scroll_right = '<C-l>',
      scroll_up = '<C-b>',

      stop = '<Esc>',

      toggle_info = '<S-Tab>',
      toggle_preview = '<Tab>',
    },

    -- General options
    options = {
      -- Whether to show content from bottom to top
      content_from_bottom = false,
      -- Whether to cache matches (more speed and memory on repeated prompts)
      use_cache = true,
    },
    -- Window related options
    window = {
      -- Float window config (table or callable returning it)
      config = function()
        -- local height = math.floor(0.6 * vim.o.lines)
        -- local width = math.floor(0.5 * vim.o.columns)

        local width = math.min(60, vim.o.columns)
        local height = math.min(20, vim.o.lines)
        -- height = 10
        -- width = 60
        return {
          anchor = 'NW',
          height = height,
          width = width,
          -- row = math.floor(0.5 * (vim.o.lines - height)),
          row = math.floor(0.5 * (vim.o.lines - height)),
          -- row = 1,
          col = math.floor(0.5 * (vim.o.columns - width)),
          -- border = 'double',
          -- border = 'solid',
          border = 'single',
        }
      end,

      -- String to use as cursor in prompt
      prompt_cursor = '▏',

      -- String to use as prefix in prompt
      prompt_prefix = '> ',
    },
  }
  mp.setup(opts)

  --- Add mini extra pickers
  require('mini.extra').setup()

  --- Registry
  mp.registry.registry = function()
    local items = vim.tbl_keys(mp.registry)
    table.sort(items)
    local source = { items = items, name = 'Registry', choose = function() end }
    local chosen_picker_name = mp.start({ source = source })
    if chosen_picker_name == nil then
      return
    end
    return mp.registry[chosen_picker_name]()
  end

  mp.registry.bufferlist = function()
    -- local buffers_output = vim.api.nvim_exec('buffers', true)
    local buffers_output = vim.api.nvim_exec2('buffers', { output = true }).output
    local curbuf = vim.api.nvim_get_current_buf()
    local curbuf_name = 'Buffers L'
    local items = {}
    --- visit order
    local order = vim.g._bufferslist
    --- Iterator
    -- vim.notify(vim.inspect(buffers_output))
    for line in string.gmatch(buffers_output, '[^\n]+') do
      local buf_num = tonumber(line:match('%d+') or 0)
      local buf_relname = line:match('"([^"]+)"')
      -- Try to skip actual buffer
      if buf_num == curbuf then
        curbuf_name = buf_num .. ' ' .. buf_relname
      else
        local buf_filename = buf_relname:match('([^/]+)$')
        local buf_relpath = buf_relname:match('(.*/)') or ''
        -- local flag = (bfactual == buf_num and '%' or (bfaltternate == buf_num and '#' or ' '))
        local realpath_str = #buf_relpath > 0 and (' `' .. buf_relpath .. '`') or ''
        table.insert(items, {
          buf = buf_num,
          text = ' ' .. buf_filename .. realpath_str,
          time = order[buf_num] or -1,
        })
      end
    end

    -- Sort items
    table.sort(items, function(a, b)
      return a.time > b.time
    end)
    local source = {
      items = items,
      name = curbuf_name,
      -- choose = function()end
      show = function(buf_id, items, query)
        vim.treesitter.start(buf_id, 'markdown')
        mp.default_show(buf_id, items, query, { show_icons = true })
      end,
      -- show = function(buf_id, items_arr, query)
      --   local lines = vim.tbl_map(function(x)
      --     -- return 'Item: ' .. x.text
      --     return x.text
      --   end, items_arr)
      --   vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
      -- end,
    }
    mp.start({ source = source })

    -- -- all existing bufers
    -- local buffers_list = vim.api.nvim_list_bufs()
    -- -- Utils
    -- local alternate_buf = vim.fn.bufnr('#')
    -- local actual_buf = vim.fn.bufnr('')
    -- local cwd = vim.fn.getcwd()
    -- -- Used buffers
    -- local buffer_items = {}
    --
    -- for _, buf_num in ipairs(buffers_list) do
    --   if vim.fn.buflisted(bfnr) ~= 0 then
    --     goto continue
    --   end
    --   if actual_buf == buf_num then
    --     goto continue
    --   end
    --
    --   local buf_fullname  = vim.api.nvim_buf_get_name(buf_num)
    --   local buf_filename = buf_fullname:match('([^/]+)$')
    --   local buf_relname  = buf_fullname:gsub("^" .. cwd, "")
    --   local buf_relpath  = buf_relname:match("(.*/).+")
    --   local flag = (bfactual == bfnr and '%' or (bfaltternate == bfnr and '#' or ' '))
    --   table.insert(buffer_items,{
    --     buf = buf_num,
    --     fullpath = buf_fullname,
    --     file = buffer_items,
    --     relpath = buf_relpath,
    --     time = order[buf_num] or -1,
    --     flag = flag
    --   })
    --     --- Catch when is skipped
    --   ::continue::
    -- end
    --
    -- table.sort(buffer_items, function(a,b)
    --   return a.time > b.time
    -- end)
    --
    -- local source = {
    --   items = buffer_items,
    --   name = "Buffers L",
    --   -- choose = function()end
    --   show = function(buf_id, items, query) mp.default_show(buf_id, items, query, { show_icons = true }) end
    -- }
    -- mp.start({source = source})
  end

  local session_func = function()
    local minisessions = require('mini.sessions')
    local detected = minisessions.detected
    local fitems, refs = {}, {}

    local homed = vim.fn.expand('~')
    local function process_item(el)
      local dir, branch = table.unpack(vim.split(el, '%%', { plain = true }))
      local parts = vim.split(dir, ' ', { plain = true })
      dir = parts[1] .. ' `' .. (parts[2] or ' ') .. '`'
      local name = (dir:gsub('%%', '/'):gsub(homed, '~'))
      branch = branch and (' _[' .. branch:gsub('%%', '/') .. ']_') or ''
      return "   "..name .. branch
    end

    for session_name, session in pairs(detected) do
      local item_name = process_item(session_name)
      table.insert(fitems, {
        text = item_name,
        _session_name = session_name,
        _mt = session.type == 'local' and math.huge or session.modify_time,
        _session = session,
      })
    end

    table.sort(fitems, function(a, b)
      return a._mt > b._mt
    end)

    local source = {
      name = 'F Sessions',
      items = fitems,
      choose = function(item)
        vim.notify(vim.inspect(item))
      end,
      show = function(buf_id, itemsl, query)
        vim.treesitter.start(buf_id, 'markdown')
        mp.default_show(buf_id, itemsl, query, { show_icons = false })
      end,
      preview = function(buf_id, item)
        local dir, branch = table.unpack(vim.split(item._session_name, '%%', { plain = true }))
        local parts = vim.split(dir, ' ', { plain = true })
        local sname = parts[1]
        local dirname = (parts[2] or ''):gsub('%%', '/')
        local branchname = branch and (' _[' .. branch:gsub('%%', '/') .. ']_') or ''

        local lines = {
          -- '**name**: `' .. item._session.name .. '`',
          '**name**: `' .. sname .. '`',
          '**path**: `' .. dirname .. '`',
          '**branch**: `' .. branchname .. '`',
          '**date**: `' .. os.date('%Y-%m-%d %H:%M:%S', item._mt) .. '`',
        }
        vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
        vim.api.nvim_set_option_value('wrap', true, {})
        vim.treesitter.start(buf_id, 'markdown')
      end,
    }
    local chosen_picker_session = mp.start({ source = source })

    -- local items = vim.tbl_keys(minisessions.detected)
    -- local fitems = {}
    -- local refs = {}

    -- local homed = vim.fn.expand('~')
    -- local function process_item(el)
    --   local dir, branch = table.unpack(vim.split(el, '%%', { plain = true }))
    --   local parts = vim.split(dir, ' ', { plain = true })
    --   dir = parts[1] .. ' `' .. (parts[2] or ' ') .. '`'
    --   local name = (dir:gsub('%%', '/'):gsub(homed, '~'))
    --   branch = branch and (' _[' .. branch:gsub('%%', '/') .. ']_') or ''
    --   return name .. branch
    -- end
    --
    -- -- table.sort(items, function(a, b)
    -- --   local a_time = a.type == 'local' and math.huge or a.modify_time
    -- --   local b_time = b.type == 'local' and math.huge or b.modify_time
    -- --   -- local a_time = a._session.type == 'local' and math.huge or a._session.modify_time
    -- --   -- local b_time = b._session.type == 'local' and math.huge or b._session.modify_time
    -- --   return a_time > b_time
    -- -- end)
    --
    -- for session_name, session in pairs(items) do
    --   vim.notify(vim.inspect(session_name))
    --   -- local item_name = process_item(session_name)
    --   -- fitems[session_name] = item_name
    -- end
    --
    -- local source = {
    --   items = fitems,
    --   -- index = indx,
    --   name = 'Sessions',
    --   -- choose = function(a,b)
    --   --   vim.notify(vim.inspect({a,b}))
    --   -- end,
    --   show = function(buf_id, itemsl, query)
    --     vim.treesitter.start(buf_id, 'markdown')
    --     mp.default_show(buf_id, itemsl, query, { show_icons = false })
    --   end,
    -- }
    -- local chosen_picker_session = mp.start({ source = source })
    -- if chosen_picker_session == nil then
    --   return
    -- end
    -- minisessions.read(refs[chosen_picker_session])
  end

  mp.registry.sessions = session_func
  mp.registry.ms = session_func
end
