--[[
Mappings shamelessly stolen from medium article:
https://medium.com/scoro-engineering/5-smart-mini-snippets-for-making-text-editing-more-fun-in-neovim-b55ffb96325a
--]]
-- automatically add "" when adding attributes in vue
vim.keymap.set("i", "=", function()
  -- The cursor location does not give us the correct node in this case, so we
  -- need to get the node to the left of the cursor
  local cursor = vim.api.nvim_win_get_cursor(0)
  local left_of_cursor_range = { cursor[1] - 1, cursor[2] - 1 }

  local node = vim.treesitter.get_node({ pos = left_of_cursor_range })
  local nodes_active_in = {
    "attribute_name",
    "directive_argument",
    "directive_name",
  }
  if not node or not vim.tbl_contains(nodes_active_in, node:type()) then
    -- The cursor is not on an attribute node
    return "="
  end

  return '=""<left>'
end, { expr = true, buffer = true, desc = "Smart vue attribute insert" })

-- auto close tag when I type `/` inside a tag
-- vim.keymap.set("i", "/", function()
--     local node = vim.treesitter.get_node()
--     if not node then return "/" end
--
--     local first_sibling_node = node:prev_named_sibling()
--     if not first_sibling_node then return "/" end
--
--     local parent_node = node:parent()
--     local is_tag_writing_in_progress = node:type() == "text" and parent_node:type() == "element"
--
--     local is_start_tag = first_sibling_node:type() == "start_tag"
--
--     local start_tag_text = vim.treesitter.get_node_text(first_sibling_node, 0)
--     local tag_is_already_terminated = string.match(start_tag_text, ">$")
--
--     if is_tag_writing_in_progress and is_start_tag and not tag_is_already_terminated then
--         local char_at_cursor = vim.fn.strcharpart(vim.fn.strpart(vim.fn.getline("."), vim.fn.col(".") - 2), 0, 1)
--         local already_have_space = char_at_cursor == " "
--
--         -- We can also automatically add a space if there isn't one already
--         return already_have_space and "/>" or " />"
--     end
--
--     return "/"
-- end, { expr = true, buffer = true, desc = "Auto close vue tag" })

vim.schedule(function()
  -- en lua (init.lua o plugin/*.lua)
  local ts_ok, tsu = pcall(require, "nvim-treesitter.ts_utils")
  if not ts_ok then return end

  local function in_start_tag()
    local node = tsu.get_node_at_cursor()
    while node do
      local t = node:type()
      -- gramáticas comunes: html/vue/xml/svelte
      if t == "start_tag" or t == "start_tag_name" or t == "tag" or t == "element" then
        -- estamos dentro del nodo de apertura
        return true
      end
      node = node:parent()
    end
    return false
  end

local function selfclose_or_literal_slash()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1
  local line = vim.api.nvim_get_current_line()

  local lt = line:sub(1, col):match(".*()<")
  if not lt then return "/" end
  if line:sub(lt, lt+1) == "</" then return "/" end
  if not in_start_tag() then return "/" end

  local gt_pos = line:find(">", col+1, true)
  if gt_pos and line:sub(gt_pos-1, gt_pos-1) == "/" then
    return "/"
  end

  if gt_pos then
    vim.api.nvim_buf_set_text(0, row, gt_pos-1, row, gt_pos-1, {"/"})
    return ""
  else
    -- chequea si antes del cursor hay espacio
    local prev_char = line:sub(col, col)
    if prev_char:match("%s") then
      return "/>"
    else
      return " />"
    end
  end
end

  -- mapping expr en Insert para tipos de archivo relevantes
  -- local ft_group = vim.api.nvim_create_augroup("SelfCloseSlash", { clear = true })
  -- vim.api.nvim_create_autocmd("FileType", {
  --   group = ft_group,
  --   pattern = { "html", "xml", "vue", "svelte" },
  --   callback = function()
      vim.keymap.set("i", "/", selfclose_or_literal_slash,
        { buffer = true, expr = true, desc = "Self-close tag with '/'" })
  --   end,
  -- })
end)
