return function()
  --- Load minifiles if nvim start with a folder
  vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("minifiles_start_directory", { clear = true }),
    desc = "Start Minifiles with directory",
    once = true,
    callback = function()
      if package.loaded["mini.files"] then
        return
      else
        local stats = vim.uv.fs_stat(vim.fn.argv(0))
        if stats and stats.type == "directory" then
          -- require("mini.files").open()
          local mf = require("mini.files")
          mf.setup()
          vim.schedule(function()
            mf.open(vim.fn.argv(0), true)
          end)
        end
      end
    end,
  })
end
