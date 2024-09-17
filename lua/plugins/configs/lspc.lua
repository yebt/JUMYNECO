return function()
  local lspc = require('lspconfig')
  local msn = require('mason')
  local msnslpc = require('mason-lspconfig')

  --- Move to dedicated opts call
  -- msn.setup()
  --- Move to dedicated opts call
  -- msnslpc.setup()

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

    ['lua_ls'] = function(sn)
      lspc[sn].setup(vim.tbl_extend('force', default_server_ops, {
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                -- Depending on the usage, you might want to add additional paths here.
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              },
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
              -- library = vim.api.nvim_get_runtime_file("", true)
            },
            -- diagnostics = {
            --   globals = {
            --     'vim',
            --   },
            -- },
          },
        },
      }))
    end,
    ['pyright'] = function(sn)
      lspc[sn].setup(vim.tbl_extend('force', default_server_ops, {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = 'openFilesOnly',
              useLibraryCodeForTypes = true,
            },
          },
        },
      }))
    end,
    ['emmet_language_server'] = function(sn)
      lspc[sn].setup(vim.tbl_extend('force', default_server_ops, {
        filetypes = {
          'css',
          'eruby',
          'html',
          'htmldjango',
          'javascriptreact',
          'less',
          'pug',
          'sass',
          'scss',
          'typescriptreact',
          'htmlangular',
          'blade',
          'php',
          'vue',
          'jsx',
        },
        init_options = {
          showAbbreviationSuggestions = true,
          -- showExpandedAbbreviation = 'always',
          showSuggestionsAsSnippets = true,
        },
      }))
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
