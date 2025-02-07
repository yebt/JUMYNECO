return function()
  local use_colors = true
  local color_mode = 'bg'
  -- local color_mode = 'fg'

  -- Make an event to set change when a colorscheme is set
  local function vanshl(name, opts)
    vim.api.nvim_set_hl(0, name, opts or {})
  end

  -- Event to set colors in the pmenu
  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = function()
      if not use_colors then
        return
      end

      -- vanshl('PmenuSel', { bg = '#282C34', fg = 'NONE' })
      -- vanshl('PmenuSel', { bg = '#EF3054', fg = 'NONE' })
      vanshl('PmenuSel', { bg = 'NONE', fg = 'NONE', bold = true, reverse = true })
      vanshl('Pmenu', { fg = '#C5CDD9', bg = '#22252A' })

      vanshl('CmpItemAbbrDeprecated', { fg = '#7E8294', bg = 'NONE', strikethrough = true })
      vanshl('CmpItemAbbrMatch', { fg = '#82AAFF', bg = 'NONE', bold = true })
      vanshl('CmpItemAbbrMatchFuzzy', { fg = '#82AAFF', bg = 'NONE', bold = true })
      vanshl('CmpItemMenu', { fg = '#C792EA', bg = 'NONE', italic = true })

      if color_mode == 'bg' then
        -- Customization for Pmenu

        vanshl('CmpItemKindField', { fg = '#EED8DA', bg = '#B5585F' })
        vanshl('CmpItemKindProperty', { fg = '#EED8DA', bg = '#B5585F' })
        vanshl('CmpItemKindEvent', { fg = '#EED8DA', bg = '#B5585F' })

        vanshl('CmpItemKindText', { fg = '#C3E88D', bg = '#9FBD73' })
        vanshl('CmpItemKindEnum', { fg = '#C3E88D', bg = '#9FBD73' })
        vanshl('CmpItemKindKeyword', { fg = '#C3E88D', bg = '#9FBD73' })

        vanshl('CmpItemKindConstant', { fg = '#FFE082', bg = '#D4BB6C' })
        vanshl('CmpItemKindConstructor', { fg = '#FFE082', bg = '#D4BB6C' })
        vanshl('CmpItemKindReference', { fg = '#FFE082', bg = '#D4BB6C' })

        vanshl('CmpItemKindFunction', { fg = '#EADFF0', bg = '#A377BF' })
        vanshl('CmpItemKindStruct', { fg = '#EADFF0', bg = '#A377BF' })
        vanshl('CmpItemKindClass', { fg = '#EADFF0', bg = '#A377BF' })
        vanshl('CmpItemKindModule', { fg = '#EADFF0', bg = '#A377BF' })
        vanshl('CmpItemKindOperator', { fg = '#EADFF0', bg = '#A377BF' })

        vanshl('CmpItemKindVariable', { fg = '#C5CDD9', bg = '#7E8294' })
        vanshl('CmpItemKindFile', { fg = '#C5CDD9', bg = '#7E8294' })

        vanshl('CmpItemKindUnit', { fg = '#F5EBD9', bg = '#D4A959' })
        vanshl('CmpItemKindSnippet', { fg = '#F5EBD9', bg = '#D4A959' })
        vanshl('CmpItemKindFolder', { fg = '#F5EBD9', bg = '#D4A959' })

        vanshl('CmpItemKindMethod', { fg = '#DDE5F5', bg = '#6C8ED4' })
        vanshl('CmpItemKindValue', { fg = '#DDE5F5', bg = '#6C8ED4' })
        vanshl('CmpItemKindEnumMember', { fg = '#DDE5F5', bg = '#6C8ED4' })

        vanshl('CmpItemKindInterface', { fg = '#D8EEEB', bg = '#58B5A8' })
        vanshl('CmpItemKindColor', { fg = '#D8EEEB', bg = '#58B5A8' })
        vanshl('CmpItemKindTypeParameter', { fg = '#D8EEEB', bg = '#58B5A8' })
      else
        -- Customization for Pmenu
        -- vanshl('PmenuSel', { fg = '#282C34', bg = 'NONE' })
        -- vanshl('Pmenu', { bg = '#C5CDD9', fg = '#22252A' })
        --
        -- vanshl('CmpItemAbbrDeprecated', { bg = '#7E8294', fg = 'NONE', strikethrough = true })
        -- vanshl('CmpItemAbbrMatch', { bg = '#82AAFF', fg = 'NONE', bold = true })
        -- vanshl('CmpItemAbbrMatchFuzzy', { bg = '#82AAFF', fg = 'NONE', bold = true })
        -- vanshl('CmpItemMenu', { bg = '#C792EA', fg = 'NONE', italic = true })

        vanshl('CmpItemKindField', { bg = '#EED8DA', fg = '#B5585F' })
        vanshl('CmpItemKindProperty', { bg = '#EED8DA', fg = '#B5585F' })
        vanshl('CmpItemKindEvent', { bg = '#EED8DA', fg = '#B5585F' })

        vanshl('CmpItemKindText', { bg = '#C3E88D', fg = '#9FBD73' })
        vanshl('CmpItemKindEnum', { bg = '#C3E88D', fg = '#9FBD73' })
        vanshl('CmpItemKindKeyword', { bg = '#C3E88D', fg = '#9FBD73' })

        vanshl('CmpItemKindConstant', { bg = '#FFE082', fg = '#D4BB6C' })
        vanshl('CmpItemKindConstructor', { bg = '#FFE082', fg = '#D4BB6C' })
        vanshl('CmpItemKindReference', { bg = '#FFE082', fg = '#D4BB6C' })

        vanshl('CmpItemKindFunction', { bg = '#EADFF0', fg = '#A377BF' })
        vanshl('CmpItemKindStruct', { bg = '#EADFF0', fg = '#A377BF' })
        vanshl('CmpItemKindClass', { bg = '#EADFF0', fg = '#A377BF' })
        vanshl('CmpItemKindModule', { bg = '#EADFF0', fg = '#A377BF' })
        vanshl('CmpItemKindOperator', { bg = '#EADFF0', fg = '#A377BF' })

        vanshl('CmpItemKindVariable', { bg = '#C5CDD9', fg = '#7E8294' })
        vanshl('CmpItemKindFile', { bg = '#C5CDD9', fg = '#7E8294' })

        vanshl('CmpItemKindUnit', { bg = '#F5EBD9', fg = '#D4A959' })
        vanshl('CmpItemKindSnippet', { bg = '#F5EBD9', fg = '#D4A959' })
        vanshl('CmpItemKindFolder', { bg = '#F5EBD9', fg = '#D4A959' })

        vanshl('CmpItemKindMethod', { bg = '#DDE5F5', fg = '#6C8ED4' })
        vanshl('CmpItemKindValue', { bg = '#DDE5F5', fg = '#6C8ED4' })
        vanshl('CmpItemKindEnumMember', { bg = '#DDE5F5', fg = '#6C8ED4' })

        vanshl('CmpItemKindInterface', { bg = '#D8EEEB', fg = '#58B5A8' })
        vanshl('CmpItemKindColor', { bg = '#D8EEEB', fg = '#58B5A8' })
        vanshl('CmpItemKindTypeParameter', { bg = '#D8EEEB', fg = '#58B5A8' })
      end
    end,
  })
end
