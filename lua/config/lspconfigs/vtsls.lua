return {
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
            location = vim.fn.stdpath('data') .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
            languages = { 'vue' },
            configNamespace = 'typescript',
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
    },
  },
  root_markers = { 'tsconfig.json', 'package.json', 'jsconfig.json', '.git' },
}
