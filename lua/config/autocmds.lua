local au = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("lotusAus", {clear = true})


au({ "FocusGained", "TermClose", "TermLeave" }, {
 group = group,
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
  desc = "Check if file need reload"
})

au("TextYankPost", {
  group = group,
  callback = function()
    vim.hl .on_yank({timeout=90})
  end,
  desc = "Highlight on yank"
})

au({ "VimResized" }, {
  group = group,
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
  desc = "resize on resize"
})

au("FileType", {
  group = group,
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
  desc = "Close some filetypes with <q>"
})

au("BufReadPost", {
  group = group,
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "load last loc"
})

-------
au('TermOpen', {
  group = group,
  command = 'setl stc= nonumber | startinsert!',
  desc = "Make a better integrated term"
})


