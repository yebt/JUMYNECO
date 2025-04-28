return function()
  local lspc = require('lspconfig')
  local util = require('lspconfig.util')
  local msn = require('mason')
  local msnslpc = require('mason-lspconfig')

  local emmet_filetypes = { 'css', 'eruby', 'html', 'htmldjango', 'javascriptreact', 'less', 'pug', 'sass', 'scss',
    'typescriptreact', 'htmlangular', 'blade', 'php', 'vue', 'jsx', 'smarty', 'tpl', 'twig', }

  --- Move to dedicated opts call
  -- msn.setup()
  --- Move to dedicated opts call
  -- msnslpc.setup()

  -- vim.diagnostic.config({
  --   update_in_insert = true,
  -- })

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

    -- NOTE: this is a better option, show abrebiations here
    ['emmet_language_server'] = function(sn)
      lspc[sn].setup(vim.tbl_extend('force', default_server_ops, {
        filetypes = emmet_filetypes,
        init_options = {
          showAbbreviationSuggestions = true,
          -- showExpandedAbbreviation = 'always',
          showSuggestionsAsSnippets = true,
        },
      }))
    end,
    ['emmet_ls'] = function(sn)
      lspc[sn].setup(vim.tbl_extend('force', default_server_ops, {
        filetypes = emmet_filetypes,
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
      local opts = vim.tbl_extend('force', default_server_ops, {
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
        single_file_support = false, -- disable for a no project
        -- not include deno
        root_dir = not vim.fs.root(0, { 'deno.json', 'deno.jsonc' }) and
            util.root_pattern('tsconfig.json', 'package.json', 'jsconfig.json', '.git'),
      })
      lspc[sn].setup(opts)
    end,

    ['denols'] = function(sn)
      vim.g.markdown_fenced_languages = {
        "ts=typescript"
      }
      -- Try some
      lspc[sn].setup({
        capabilities = default_server_ops.capabilities,
        root_dir = false,
        root_dir = vim.fs.root(0, { 'deno.json', 'deno.jsonc' }) or false,
        --     util.root_pattern('deno.json', 'deno.jsonc', '.git'),
        settings = {
          deno = {
            enable = true,
            suggest = {
              imports = {
                hosts = {
                  ['https://deno.land'] = true,
                },
              },
            },
          },
        },
      })
      -- Last
      -- lspc[sn].setup(vim.tbl_extend('force', default_server_ops, {
      --   -- init_options = {
      --   --   lint = true,
      --   --   unstable = true,
      --   --   suggest = {
      --   --     imports = {
      --   --       hosts = {
      --   --         ["https://deno.land"] = true,
      --   --         ["https://cdn.nest.land"] = true,
      --   --         ["https://crux.land"] = true,
      --   --       },
      --   --     },
      --   --   },
      --   -- },
      --   settings = {
      --     deno = {
      --       enable = true,
      --       lint=true,
      --       suggest = {
      --         autoImports=true,
      --         imports = {
      --           autoDiscover = true,
      --           hosts = {
      --             ["https://deno.land"] = true,
      --             ["https://nest.land"] = true,
      --             ["https://crux.land/"] = true,
      --           }
      --         }
      --       }
      --     }
      --   }
      --
      -- }))
    end,

    -- NOTE: allow completion in cssls cause is like snippets
    ['cssls'] = function(sn)
      local lCapabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      lspc[sn].setup({
        capabilities = lCapabilities
      })
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

    ['intelephense'] = function(sn)
      local itlps_capabilities = default_server_ops.capabilities
      lspc[sn].setup({
        capabilities = itlps_capabilities,
        settings = {
          intelephense = {
            diagnostics = {
              enable = true
            },
            format = {
              enable = true
            }
          }
        }
        -- settings = {
        --   intelephense = {
        --     diagnostics = {
        --       enable = true
        --     },
        --     format = {
        --       enable = true
        --     }
        --   }
        -- }
      })
    end
  })

  -- Set up lspconfig.
  -- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
  --   capabilities = capabilities
  -- }
end
