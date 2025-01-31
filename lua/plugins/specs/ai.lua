--[[
--This file contains the AI agents and things
--]]

-- local copai = "supermaven-nvim"
-- local copai = "codeium.nvim"
local copai = ""

local function isCopAI (plugin)
  return plugin.name == (copai or nil)
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

  -- Codeium
  {
    'Exafunction/codeium.nvim',
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    event = { 'InsertEnter' },
    cond = isCopAI,
    config = require('plugins.configs.codeiumc'),
  }
}
