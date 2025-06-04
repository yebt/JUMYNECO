local utils = require("modules.utils")
local path_concat = utils.path_concat
local mason_root_dir = utils.mason_root_dir

return {
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          --- Used fot typescript in vue projects
          {
            name = '@vue/typescript-plugin',
            location = path_concat({
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
}
