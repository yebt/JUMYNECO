return  {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      -- schemas = jschemas,
      validate = { enable = true },
    },
  },
}
