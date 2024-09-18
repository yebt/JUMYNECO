return function()
  local conform = require('conform')

  local function frmt()
    local registry = require('mason-registry')
    registry.refresh(function()
      local packages = registry.get_installed_packages()
      local packages_names = vim.tbl_map(function(el)
        return el.name or '??'
      end, packages)
      vim.notify(vim.inspect(packages_names))
    end)
  end

  vim.keymap.set('n', '<leader>f', frmt, { silent = true, noremap = true, desc = 'Conform try format' })
end
