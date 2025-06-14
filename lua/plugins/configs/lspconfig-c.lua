return function()
  local lspconfig                      = require('lspconfig')
  local blink                          = require('blink.cmp')

  local capabilities                   = blink.get_lsp_capabilities()
  capabilities.window                  = capabilities.window or {}
  capabilities.window.workDoneProgress = true

  -- local lsp_settings = {
  --
  -- }

  local lsp_settings                   = {

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

    ['cssls'] = {},
    ['denols'] = {
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
    ['emmet_language_server'] = {
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
        'smarty',
        'tpl',
        'twig',
      },
      init_options = {
        showAbbreviationSuggestions = true,
        -- showExpandedAbbreviation = 'always',
        showSuggestionsAsSnippets = true,
      },
    },

    ['intelephense'] = {
      init_options = {
        licenceKey = vim.fn.expand('~') .. '/intelephense/licence.txt',
      },

      capabilities = capabilities,
      settings = {
        intelephense = {
          client = {
            -- Al escribir /** se autoinserta */ y se muestra el completado de PHPDoc
            autoCloseDocCommentDoSuggest = true,
          },
          files = {
            maxSize = 10000000,
            exclude = {
              "**/.git/**",
              "**/.svn/**",
              "**/.hg/**",
              "**/CVS/**",
              "**/.DS_Store/**",
              "**/node_modules/**",
              "**/bower_components/**",
              "**/vendor/**/{Tests,tests}/**",
              "**/.history/**",
              "**/vendor/**/vendor/**"
            }
          },
          diagnostics = {
            enable = true,
          },
          format = {
            enable = true,
          },
          phpdoc = {
            textFormat = 'snippet'
          }, -- asegura snippet output
          completion = {
            fullyQualifyGlobalConstantsAndFunctions = true,
          },

        },
      },

      on_attach = function(client, bufnr)
        local api = vim.api

        -- 2.3 Comando para forzar indexación del workspace
        api.nvim_buf_create_user_command(bufnr, 'IntelephenseIndex', function()
          client.request(
            'workspace/executeCommand',
            { command = 'intelephense.index.workspace' },
            function(err)
              if err then
                vim.notify('Error al iniciar indexación: ' .. err.message, vim.log.levels.ERROR)
              else
                vim.notify('Indexación de Intelephense iniciada', vim.log.levels.INFO)
              end
            end,
            bufnr
          )
        end, { desc = 'Indexar workspace con Intelephense' })

        -- 2.4 Escuchar notificaciones de progreso y mostrarlas
        client.handlers['window/workDoneProgress/create'] = function(err, result)
          if not err and result then
            vim.notify('Intelephense: ' .. result.title, vim.log.levels.INFO)
          end
        end
        client.handlers['$/progress'] = function(err, result)
          if not err and result.value and result.value.message then
            vim.notify('Intelephense: ' .. result.value.message, vim.log.levels.INFO)
          end
        end
      end
    },
    -- ['intelephense'] = {
    --   init_options = {
    --     licenceKey = vim.fn.expand('~') .. '/intelephense/licence.txt',
    --   },
    --   filetypes = { 'php', 'phtml' },
    --   settings = {
    --     intelephense = {
    --       diagnostics = {
    --         enable = true,
    --       },
    --       format = {
    --         enable = true,
    --       },
    --       -- phpdoc = { textFormat = 'snippet' }, -- asegura snippet output
    --       -- completion = {
    --       --   fullyQualifyGlobalConstantsAndFunctions = true,
    --       -- },
    --       phpdoc = { textFormat = 'snippet' }, -- asegura snippet output
    --       completion = { fullyQualifyGlobalConstantsAndFunctions = true },
    --       -- progress = {
    --       --   enable = true,
    --       -- },
    --     },
    --     -- phpdoc = { textFormat = 'snippet' },             -- asegura snippet output
    --     -- completion = { fullyQualifyGlobalConstantsAndFunctions = true },
    --   },
    --   -- on_attach = function(client, bufnr)
    --   --   require('intelephense_cmds').setup(client, bufnr)
    --   -- end,
    -- },
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
    --- NOTE: OLD ts server, now i use vtsls
    ['ts_ls'] = {
      filetypes = {
        'javascript',
        'typescript',
        'vue',
      },
      init_options = {
        plugins = {
          {
            name = '@vue/typescript-plugin',
            location = vim.fn.stdpath('data')
                .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
            languages = { 'vue' },
          },
        },
      },
      settings = {
        typescript = {
          tsserver = {
            useSyntaxServer = false,
          },
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    },
    ['vtsls'] = {
      filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
        'vue',
      },
      settings = {
        vtsls = {
          tsserver = {
            globalPlugins = {
              --- Used fot typescript in vue projects
              {
                name = '@vue/typescript-plugin',
                location = vim.fn.stdpath('data')
                    .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
                languages = { 'vue' },
                configNamespace = 'typescript',
                enableForWorkspaceTypeScriptVersions = true,
              },
            },
          },
        },
      },
      root_markers = { 'tsconfig.json', 'package.json', 'jsconfig.json', '.git' },
    },
    ['vue_ls'] = {
      -- filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      init_options = {
        vue = {
          -- disable hybrid mode, this dont need ts_ls with vue ts plugni
          -- hybridMode = false,

          hybridMode = true, -- Use vtsls to manage typescript
        },
        -- typescript = {
        --   tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
        -- },
      },
    },
    ['jsonls'] = {
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          -- schemas = jschemas,
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
  }

  for srvr, srvr_settings in pairs(lsp_settings) do
    vim.lsp.config(srvr, srvr_settings)
  end
  -- local lspconfigsdir = vim.fn.stdpath 'config' .. "/lua/config/lspconfigs"
  --
  -- local function ends_with(str, ending)
  --   return ending == "" or str:sub(-#ending) == ending
  -- end
  --
  -- -- Iterate through files in the directory
  -- for _, file in ipairs(vim.fn.readdir(lspconfigsdir)) do
  --
  --   if ends_with(file, '.lua') then
  --     local mod = file:gsub('%.lua$', '')   -- Remove .lua extension
  --     local server_name = mod
  --     local server_settings = require('config.lspconfigs.'..mod)
  --     vim.lsp.enable(server_name)
  --     vim.lsp.config(server_name,server_settings)
  --   end
  -- end
end
