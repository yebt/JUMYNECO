return function()
  local lspc = require('lspconfig')
  local msn = require('mason')
  local msnslpc = require('mason-lspconfig')

  msn.setup({
    ui = {
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗',
      },
    },
  })

  msnslpc.setup({
    ensure_installed = { 'lua_ls' },
  })

  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  local default_server_ops = {
    capabilities = capabilities,
  }
  function make_opts(nops)
    return vim.tbl_extend('force', default_server_ops, nops)
  end

  msnslpc.setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
      lspc[server_name].setup(default_server_ops)
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ['rust_analyzer'] = function()
    --   require('rust-tools').setup({})
    -- end,
  })

  -- Set up lspconfig.
  -- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
  --   capabilities = capabilities
  -- }
end
