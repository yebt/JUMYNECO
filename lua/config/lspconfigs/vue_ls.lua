return {
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
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
}
