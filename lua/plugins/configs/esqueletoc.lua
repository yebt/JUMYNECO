return function()
  local sqltn = require("esqueleto")
  local opts = {
    autouse = true,                                           -- whether to auto-use a template if it's the only one for a pattern
    directories = { vim.fn.stdpath("config") .. "/skeletons" }, -- template directories
    patterns = function(dir) return vim.fn.readdir(dir) end,  -- trigger patterns for file creation,
    -- file name trigger has priority

    -- Wild-card options
    ---@type Esqueleto.WildcardConfig
    wildcards = {
      expand = true, -- whether to expand wild-cards
      lookup = {   -- wild-cards look-up table
        -- File-specific
        ["filename"] = function() return vim.fn.expand("%:t:r") end,
        ["fileabspath"] = function() return vim.fn.expand("%:p") end,
        ["filerelpath"] = function() return vim.fn.expand("%:p:~") end,
        ["fileext"] = function() return vim.fn.expand("%:e") end,
        ["filetype"] = function() return vim.bo.filetype end,

        -- Datetime-specific
        ["date"] = function() return os.date("%Y%m%d", os.time()) end,
        ["year"] = function() return os.date("%Y", os.time()) end,
        ["month"] = function() return os.date("%m", os.time()) end,
        ["day"] = function() return os.date("%d", os.time()) end,
        ["time"] = function() return os.date("%T", os.time()) end,

        -- System-specific
        ["host"] = utils.capture("hostname", false),
        ["user"] = os.getenv("USER"),

        -- Github-specific
        ["gh-email"] = utils.capture("git config user.email", false),
        ["gh-user"] = utils.capture("git config user.name", false),
      },
    },

    -- Advanced options
    ---@type Esqueleto.AdvancesConfig
    advanced = {
      ignored = {},         -- List of glob patterns or function that determines if a file is ignored
      ignore_os_files = true, -- whether to ignore OS files (e.g. .DS_Store)
    }
  }
  sqltn.setup(opts)
end
