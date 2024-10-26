return function()
  --- Load minifiles if nvim start with a folder
  vim.api.nvim_create_autocmd({"BufEnter", "VimEnter"}, {
    group = vim.api.nvim_create_augroup("minifiles_start_directory", { clear = true }),
    desc = "Start Minifiles with directory",
    once = true,
    callback = function()
      if package.loaded["mini.files"] then
        return
      else
        local stats = vim.uv.fs_stat(vim.fn.argv(0))
          require("mini.files")
        if stats and stats.type == "directory" then
          vim.schedule(function()
            vim.api.nvim_exec_autocmds("BufEnter", {
              pattern = "*",
              modeline = false,
            })
            -- MiniFiles.open()
            -- mf.open()
          -- require("mini.files").open()
          end)
        end
      end
    end,
  })
end
