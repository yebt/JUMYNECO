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

  --- Add foldingRange to capabilities
  default_server_ops.capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  --- Add discover new files in capabilities
  default_server_ops.capabilities.workspace = {
    didChangeWatchedFiles = {
      dynamicRegistration = true,
    }
  }


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

    ['jsonls'] = function(sn)
      lspc[sn].setup(vim.tbl_extend('force', default_server_ops, {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      }))
    end,

    ['yamlls'] = function(sn)
      lspc[sn].setup(vim.tbl_extend('force', default_server_ops, {
        settings = {
          yaml = {
            schemaStore = {
              -- You must disable built-in schemaStore support if you want to use
              -- this plugin and its advanced options like `ignore`.
              enable = false,
              -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
              url = '',
            },
            schemas = require('schemastore').yaml.schemas(),
          },
        },
      }))
    end,
    -- ['tailwindcss'] = function(sn)
    --   -- lspc[sn].setup(vim.tbl_extend('force', default_server_ops, {
    --   --   flags = { debounce_text_changes = 300 },
    --   --   tailwindCSS = {
    --   --     emmetCompletions = false,
    --   --     colorDecorators = false,
    --   --     showPixelEquivalents = false,
    --   --     hovers = false,
    --   --     suggestions = false,
    --   --     codeActions = false,
    --   --     classAttributes = { 'class', 'className', 'class:list', 'classList', 'ngClass' },
    --   --     includeLanguages = {
    --   --       eelixir = 'html-eex',
    --   --       eruby = 'erb',
    --   --       htmlangular = 'html',
    --   --       templ = 'html',
    --   --     },
    --   --     lint = {
    --   --       cssConflict = 'warning',
    --   --       invalidApply = 'error',
    --   --       invalidConfigPath = 'error',
    --   --       invalidScreen = 'error',
    --   --       invalidTailwindDirective = 'error',
    --   --       invalidVariant = 'error',
    --   --       recommendedVariantOrder = 'warning',
    --   --     },
    --   --     validate = false,
    --   --   },
    --   -- }))
    -- end,
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
