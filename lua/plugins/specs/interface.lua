--- UI Interfaces
return {

  --- My status line
  {
    -- "yebt/fastline.nvim",
    dir = '/home/de-web/Develop/repositories/fastline.nvim',
    event = 'VeryLazy',
    dev = true,
    -- opts = {
    --   sections = {
    --     left = { 'filename' },
    --     center = {'lsp'},
    --     right = { 'startup', 'mode' },
    --     -- puedes agregar "git", "filename", etc.
    --   },
    -- }
    config = function()
      require('fastline').register('clock', function()
        return os.date('%H:%M:%S')
      end)

      require('fastline').setup({
        sections = {
          left = {
            "mode",
            -- { text = " | ", hl = "FastlineSeparator" },
            { text = "%{&fileencoding}", hl = "FastlineEncoding" },
          },
          center = { "filename" },
          right = {"startup", "lsp", "git" },

          -- left = { 'mode' },
          -- center = {},
          -- right = { 'clock' },
        },
      })
    end,
  },
}
