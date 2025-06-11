local lsp_utils = require('lspconfig.util')
return {
  root_dir = function(bufnr, on_dir)
    -- vim.print(vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc' }) )
     if vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc' }) then
       on_dir(vim.fn.getcwd())
     end
  end,
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
}
