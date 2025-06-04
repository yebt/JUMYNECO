
return {
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
}
