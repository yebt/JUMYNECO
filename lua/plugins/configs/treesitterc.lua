return function()
  local configs = require('nvim-treesitter.configs')
  configs.setup({
    ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline' },
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = true,
    auto_install = true,

    -- List of parsers to ignore installing (or "all")
    ignore_install = { 'javascript', 'typescript' },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-space>',
        node_incremental = '<C-space>',
        scope_incremental = false,
        node_decremental = '<bs>',
      },
    },
    indent = {
      enable = true,
    },
  })

  vim.wo.foldmethod = 'expr'
  vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

  -- try to install blade parser
  local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
  parser_config.blade = {
    install_info = {
      url = "https://github.com/EmranMR/tree-sitter-blade",
      files = { "src/parser.c" },
      branch = "main",
    },
    filetype = "blade"
  }
  -- auto command for set *.blade.php to blade filetype
  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { "*.blade.php" },
    command = "set filetype=blade",
  })
end
