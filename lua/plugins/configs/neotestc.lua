return function()
  local neotest = require("neotest")
  local opts = {
    adapters = {
      require("neotest-phpunit"),
      require('neotest-pest'),
      require("neotest-vitest"),
    },
  }
  neotest.setup(opts)
end
