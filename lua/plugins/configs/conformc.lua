return function()
  local conform = require('conform')

  local function frmt()
    local registry = require('mason-registry')
    registry.refresh(function()
      local packages = registry.get_installed_packages()
      vim.notify(vim.inspect(packages))
    end)
  end

  vim.keymap.set('n', '<leader>f', frmt, { silent = true, noremap = true, desc = 'Conform try format' })
end
