return function()
  local lspc = require('lspconfig')
  local msn = require('mason')
  local msnslpc = require('mason-lspconfig')

  --- Move to dedicated opts call
  -- msn.setup()
  --- Move to dedicated opts call
  -- msnslpc.setup()

  vim.diagnostic.config({
    update_in_insert = true,
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if ok then
    capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
  end
  -- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())


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
    },
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

    -- ['vtsls'] = function(sn)
    --   lspc[sn].setup(vim.tbl_extend('force', default_server_ops, {
    --
    --     -- explicitly add default filetypes, so that we can extend
    --     -- them in related extras
    --     filetypes = {
    --       'javascript',
    --       'javascriptreact',
    --       'javascript.jsx',
    --       'typescript',
    --       'typescriptreact',
    --       'typescript.tsx',
    --     },
    --     settings = {
    --       complete_function_calls = true,
    --       vtsls = {
    --         enableMoveToFileCodeAction = true,
    --         autoUseWorkspaceTsdk = true,
    --         experimental = {
    --           completion = {
    --             enableServerSideFuzzyMatch = true,
    --           },
    --         },
    --       },
    --       typescript = {
    --         updateImportsOnFileMove = { enabled = 'always' },
    --         suggest = {
    --           completeFunctionCalls = true,
    --         },
    --         inlayHints = {
    --           enumMemberValues = { enabled = true },
    --           functionLikeReturnTypes = { enabled = true },
    --           parameterNames = { enabled = 'literals' },
    --           parameterTypes = { enabled = true },
    --           propertyDeclarationTypes = { enabled = true },
    --           variableTypes = { enabled = false },
    --         },
    --       },
    --     },
    --   }))
    --   local name = 'vtsls'
    --   vim.api.nvim_create_autocmd('LspAttach', {
    --     callback = function(args)
    --       local buffer = args.buf ---@type number
    --       local client = vim.lsp.get_client_by_id(args.data.client_id)
    --       if client and (not name or client.name == name) then
    --         vim.notify('vtsls --- ')
    --         client.commands['_typescript.moveToFileRefactoring'] = function(command, ctx)
    --           ---@type string, string, lsp.Range
    --           local action, uri, range = table.unpack(command.arguments)
    --
    --           local function move(newf)
    --             client.request('workspace/executeCommand', {
    --               command = command.command,
    --               arguments = { action, uri, range, newf },
    --             })
    --           end
    --
    --           local fname = vim.uri_to_fname(uri)
    --           client.request('workspace/executeCommand', {
    --             command = 'typescript.tsserverRequest',
    --             arguments = {
    --               'getMoveToRefactoringFileSuggestions',
    --               {
    --                 file = fname,
    --                 startLine = range.start.line + 1,
    --                 startOffset = range.start.character + 1,
    --                 endLine = range['end'].line + 1,
    --                 endOffset = range['end'].character + 1,
    --               },
    --             },
    --           }, function(_, result)
    --             ---@type string[]
    --             local files = result.body.files
    --             table.insert(files, 1, 'Enter new path...')
    --             vim.ui.select(files, {
    --               prompt = 'Select move destination:',
    --               format_item = function(f)
    --                 return vim.fn.fnamemodify(f, ':~:.')
    --               end,
    --             }, function(f)
    --               if f and f:find('^Enter new path') then
    --                 vim.ui.input({
    --                   prompt = 'Enter move destination:',
    --                   default = vim.fn.fnamemodify(fname, ':h') .. '/',
    --                   completion = 'file',
    --                 }, function(newf)
    --                   return newf and move(newf)
    --                 end)
    --               elseif f then
    --                 move(f)
    --               end
    --             end)
    --           end)
    --         end
    --       end
    --     end,
    --   })
    --
    --   -- lspc[sn].setup(vim.tbl_extend('force', default_server_ops, {
    --   --
    --   -- }))
    -- end,
    ['vtsls'] = function(sn)
      lspc[sn].setup(vim.tbl_extend('force', default_server_ops, {
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                --- Used fot typescript in vue projects
                {
                  name = '@vue/typescript-plugin',
                  location = require('mason-registry').get_package('vue-language-server'):get_install_path()
                    .. '/node_modules/@vue/language-server',
                  languages = { 'vue' },
                  configNamespace = 'typescript',
                  enableForWorkspaceTypeScriptVersions = true,
                },
              },
            },
          },
        },
      }))
    end,

    ['astro'] = function(sn)
      lspc[sn].setup(vim.tbl_extend('force', default_server_ops, {

        filetypes = {
          'astro',
          'typescript',
          'javascript',
          -- 'typescriptreact', 'javascriptreact',
          -- 'svelte', 'svelte.svelte', 'vue', 'vue.vue',
          -- 'astro-markdown', 'astro-markdown.md',
          -- 'astro-html', 'astro-html.astro',
        },
        init_options = {
          updateImportsOnFileMove = { enabled = 'always' },
          suggest = {
            completeFunctionCalls = true,
          },
          inlayHints = {
            enumMemberValues = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            parameterNames = { enabled = 'literals' },
            parameterTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            variableTypes = { enabled = false },
          },
        },
      }))
    end,
  })

  -- Set up lspconfig.
  -- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
  --   capabilities = capabilities
  -- }
end
