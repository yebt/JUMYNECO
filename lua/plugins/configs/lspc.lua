return function()
  local lspc = require('lspconfig')
  local lsp_utils = require('lspconfig.util')
  local msn = require('mason')
  local path = require('mason-core.path')
  local msn_lspc = require('mason-lspconfig')
  -- local dap = require('dap')
  local msn_dap = require('mason-nvim-dap')

  local stdpath = vim.fn.stdpath

  --- Vars
  local emmet_filetypes = {
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
    'smarty',
    'tpl',
    'twig',
  }
  local mason_root_dir = path.concat({ stdpath('data'), 'mason' })

  --- Capabilities
  local personal_capabilities = {
    textDocument = {
      -- Semantik tokens
      semanticTokens = {
        multilineTokenSupport = true,
      },
      -- Completion capabilities
      completion = {
        completionItem = {
          snippetSupport = true,
        },
      },
      -- Folds
      -- foldingRange = {
      --   dynamicRegistration = false,
      --   lineFoldingOnly = true
      -- }
    },

    --- Discover new files
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  }

  capabilities = require('blink.cmp').get_lsp_capabilities(personal_capabilities)

  -- local capabilities = vim.lsp.protocol.make_client_capabilities()
  --
  -- capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))
  --
  -- capabilities = vim.tbl_deep_extend('force', capabilities, {
  --   textDocument = {
  --     foldingRange = {
  --       dynamicRegistration = false,
  --       lineFoldingOnly = true
  --     }
  --   }
  -- })

  --- Startups --------------------
  --- Mason
  msn.setup({
    install_root_dir = mason_root_dir,
    ---@type '"prepend"' | '"append"' | '"skip"'
    PATH = 'prepend',
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 6,
    ui = {
      check_outdated_packages_on_open = true,
      border = 'shadow',
      icons = {
        package_installed = '🜍',
        package_pending = '🜛',
        package_uninstalled = 'x',
      },
    },
  })

  --- Mason Lspconfig Bridge
  msn_lspc.setup({
    automatic_enable = true, -- automatic enable with vim.lsp.enable(...)
    ensure_installed = {
      'lua_ls',
    },
  })

  -- DAP
  -- Mason Dap Bridge
  msn_dap.setup({})

  --- Server Settings --------------------------
  local server_opts = {
    ['lua_ls'] = {
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
    },

    ['pyright'] = {
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = 'openFilesOnly',
            useLibraryCodeForTypes = true,
          },
        },
      },
    },

    ['jsonls'] = {
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    },

    ['yamlls'] = {
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
    },

    ['emmet_language_server'] = {
      filetypes = emmet_filetypes,
      init_options = {
        showAbbreviationSuggestions = true,
        -- showExpandedAbbreviation = 'always',
        showSuggestionsAsSnippets = true,
      },
    },

    ['emmet_ls'] = {
      filetypes = emmet_filetypes,
      init_options = {
        showAbbreviationSuggestions = true,
        -- showExpandedAbbreviation = 'always',
        showSuggestionsAsSnippets = true,
      },
    },

    ['vtsls'] = {
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      settings = {
        vtsls = {
          tsserver = {
            globalPlugins = {
              --- Used fot typescript in vue projects
              {
                name = '@vue/typescript-plugin',
                location = path.concat({
                  mason_root_dir,
                  '/packages/vue-language-server/', -- check inside mason root, sometimes could be change
                  '/node_modules/@vue/language-server',
                }),
                -- location = require('mason-registry').get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server',
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
      -- root_dir = not vim.fs.root(0, { 'deno.json', 'deno.jsonc' })
      --   and lsp_utils.root_pattern('tsconfig.json', 'package.json', 'jsconfig.json', '.git'),
    },

    ['volar'] = {
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      -- Not use vtsls
      -- init_options = {
      --   vue = {
      --     -- disable hybrid mode
      --     -- NOTE: its awful
      --     hybridMode = false,
      --   },
      -- },
    },

    ['denols'] = {
      root_dir = false,
      -- root_dir = vim.fs.root(0, { 'deno.json', 'deno.jsonc' }) or false,
      --     util.root_pattern('deno.json', 'deno.jsonc', '.git'),

      -- init_options = {
      --   lint = true,
      --   unstable = true,
      --   suggest = {
      --     imports = {
      --       hosts = {
      --         ["https://deno.land"] = true,
      --         ["https://cdn.nest.land"] = true,
      --         ["https://crux.land"] = true,
      --       },
      --     },
      --   },
      -- },
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
    },

    ['cssls'] = {},

    ['astro'] = {
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
    },

    ['intelephense'] = {
      settings = {
        intelephense = {
          diagnostics = {
            enable = true,
          },
          format = {
            enable = true,
          },
        },
      },
    },

    ['tailwindcss'] = {

    }
  }
  -- Set default configs
  vim.lsp.config('*', {
    capabilities = capabilities,
  })
  for srvr_name, srvr_configs in pairs(server_opts) do
    srvr_configs.capabilities = capabilities
    vim.lsp.config(srvr_name, srvr_configs)
  end
end
