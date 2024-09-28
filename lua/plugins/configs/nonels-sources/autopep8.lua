local h = require('null-ls.helpers')
local u = require('null-ls.utils')
local methods = require('null-ls.methods')

local FORMATTING = methods.internal.FORMATTING
local RANGE_FORMATTING = methods.internal.RANGE_FORMATTING

return h.make_builtin({
  name = 'autopep8',
  meta = {
    url = 'https://github.com/hhatto/autopep8',
    description = 'A tool that automatically formats Python code to conform to the PEP 8 style guide.',
  },
  method = { FORMATTING, RANGE_FORMATTING },
  filetypes = { 'python' },
  generator_opts = {
    command = 'autopep8',
    args = function(params)
      if params.method == FORMATTING then
        return {
          '--in-place',
          '--aggressive',
          '--aggressive',
          '$FILENAME',
        }
      end

      local row, end_row = params.range.row, params.range.end_row
      return {
        '--in-place',
        '-a',
        '-a',
        '--line-range ' .. row .. ' ' .. end_row,
        '$FILENAME',
      }
    end,
    to_stdin = false,
    to_temp_file = true,
    -- cwd = h.cache.by_bufnr(function(params)
    --   return u.root_pattern(
    --   -- https://black.readthedocs.io/en/stable/usage_and_configuration/the_basics.html#configuration-via-a-file
    --     "pyproject.toml"
    --   )(params.bufname)
    -- end),
  },
  factory = h.formatter_factory,
})
