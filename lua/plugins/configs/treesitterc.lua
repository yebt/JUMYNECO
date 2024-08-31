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
    -- indent = {
    --   enable = true,
    -- },
  })
end

