--[[
--This file contains the AI agents and things
--]]

-- local copai = "supermaven-nvim"
local copai = ""

local function isCopAI (plugin)
  vim.notify(vim.inspect(plugin.name))
  return plugin.name == copai
end
return {

  --- Supermaven
  {
    'supermaven-inc/supermaven-nvim',
    --  event = 'VeryLazy',
    event = { 'InsertEnter' },
    cond = isCopAI,
    config = require('plugins.configs.smaven'),
  },

  --
}
