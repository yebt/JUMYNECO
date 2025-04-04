return function()
  local blnkp = require('blink.pairs')

  local function makePair(pairStr)
    return {
      pairStr, space=true,enter=true
    }
  end

  -- @module 'blink.pairs'
  -- @type blink.pairs.Config
  local opts = {
    mappings = {
      -- you can call require("blink.pairs.mappings").enable() and require("blink.pairs.mappings").disable() to enable/disable mappings at runtime
      enabled = true,
      -- see the defaults: https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L10
      pairs = {
        ['('] = makePair(')'),
        ['['] = makePair(']'),
        ['{'] = makePair('}'),
      },
    },
    highlights = {
      enabled = true,
      groups = {
        'BlinkPairsOrange',
        'BlinkPairsPurple',
        'BlinkPairsBlue',
      },
      matchparen = {
        enabled = true,
        group = 'MatchParen',
      },
    },
    debug = false,
  }

  blnkp.setup(opts)
end
