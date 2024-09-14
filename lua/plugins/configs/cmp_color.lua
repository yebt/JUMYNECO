local function numberToHexColor(number)
  -- Asegurarse de que el número esté dentro del rango válido (0 a 16777215)
  if number < 0 then
    number = 0
  end
  if number > 16777215 then
    number = 16777215
  end

  -- Convertir el número a hexadecimal
  local hex = string.format('%06X', number)

  -- Agregar el símbolo '#' al inicio
  return '#' .. hex
end

local function rgb(c)
  c = string.lower(c)
  return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

local function blend(foreground, alpha, background)
  alpha = type(alpha) == 'string' and (tonumber(alpha, 16) / 0xff) or alpha
  local bg = rgb(background)
  local fg = rgb(foreground)

  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format('#%02x%02x%02x', blendChannel(1), blendChannel(2), blendChannel(3))
end

local function colorize_cmp(opts)
  local revert = opts and opts.revert or true

  --- Bases
  local actual_bg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg or '#242424'
  if type(actual_bg) == 'number' then
    actual_bg = numberToHexColor(actual_bg)
  end
  --- Params
  local light_bg = '#bebebe'
  local dark_bg = '#121212'
  local alpha_points = 0.1
  --- Functions
  local darken = function(color, amount)
    amount = amount or alpha_points
    return blend(color, amount, dark_bg)
  end
  local lighten = function(color, amount)
    amount = amount or alpha_points
    return blend(color, amount, light_bg)
  end

  -- Customization for Pmenu
  -- local bgPmenu = blend(actual_bg, 0.6, '#000000')
  local bgPmenu = blend(actual_bg, 0.55, '#000000')
  -- local fgPmenu =  blend(actual_bg, 0.2, '#FFFFFF')
  local fgPmenu = blend(actual_bg, 0.25, '#FFFFFF')

  local bgPmenuSel = blend(actual_bg, 0.95, '#FFFFFF')

  vim.api.nvim_set_hl(0, 'Pmenu', {
    bg = bgPmenu,
    fg = fgPmenu,
  })
  vim.api.nvim_set_hl(0, 'PmenuSel', {
    bg = bgPmenuSel,
    fg = 'NONE',
  })

  vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { fg = '#7E8294', bg = 'NONE', strikethrough = true })
  vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { fg = '#82AAFF', bg = 'NONE', bold = true })
  vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { fg = '#82AAFF', bg = 'NONE', bold = true })
  vim.api.nvim_set_hl(0, 'CmpItemMenu', { fg = '#C792EA', bg = 'NONE', italic = true })

  -- vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#282C34', fg = 'NONE' })
  -- vim.api.nvim_set_hl(0, 'Pmenu', { fg = '#C5CDD9', bg = '#22252A' })

  -- vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { fg = '#7E8294', bg = 'NONE', strikethrough = true })
  -- vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { fg = '#82AAFF', bg = 'NONE', bold = true })
  -- vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { fg = '#82AAFF', bg = 'NONE', bold = true })
  -- vim.api.nvim_set_hl(0, 'CmpItemMenu', { fg = '#C792EA', bg = 'NONE', italic = true })

  if revert then
    -- vim.api.nvim_set_hl(0 , 'PmenuSel'                 , { fg = '#282C34' , bg = 'NONE' })
    -- vim.api.nvim_set_hl(0 , 'Pmenu'                    , { bg = '#C5CDD9' , fg = '#22252A' })

    -- vim.api.nvim_set_hl(0 , 'CmpItemAbbrDeprecated'    , { bg = '#7E8294' , fg = 'NONE'       , strikethrough = true })
    -- vim.api.nvim_set_hl(0 , 'CmpItemAbbrMatch'         , { bg = '#82AAFF' , fg = 'NONE'       , bold = true })
    -- vim.api.nvim_set_hl(0 , 'CmpItemAbbrMatchFuzzy'    , { bg = '#82AAFF' , fg = 'NONE'       , bold = true })
    -- vim.api.nvim_set_hl(0 , 'CmpItemMenu'              , { bg = '#C792EA' , fg = 'NONE'       , italic = true })

    vim.api.nvim_set_hl(0, 'CmpItemKindField', { bg = blend('#B5585F', alpha_points, bgPmenu), fg = '#B5585F' })
    vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { bg = blend('#B5585F', alpha_points, bgPmenu), fg = '#B5585F' })
    vim.api.nvim_set_hl(0, 'CmpItemKindEvent', { bg = blend('#B5585F', alpha_points, bgPmenu), fg = '#B5585F' })
    vim.api.nvim_set_hl(0, 'CmpItemKindText', { bg = blend('#9FBD73', alpha_points, bgPmenu), fg = '#9FBD73' })
    vim.api.nvim_set_hl(0, 'CmpItemKindEnum', { bg = blend('#9FBD73', alpha_points, bgPmenu), fg = '#9FBD73' })
    vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = blend('#9FBD73', alpha_points, bgPmenu), fg = '#9FBD73' })
    vim.api.nvim_set_hl(0, 'CmpItemKindConstant', { bg = blend('#D4BB6C', alpha_points, bgPmenu), fg = '#D4BB6C' })
    vim.api.nvim_set_hl(0, 'CmpItemKindConstructor', { bg = blend('#D4BB6C', alpha_points, bgPmenu), fg = '#D4BB6C' })
    vim.api.nvim_set_hl(0, 'CmpItemKindReference', { bg = blend('#D4BB6C', alpha_points, bgPmenu), fg = '#D4BB6C' })
    vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = blend('#A377BF', alpha_points, bgPmenu), fg = '#A377BF' })
    vim.api.nvim_set_hl(0, 'CmpItemKindStruct', { bg = blend('#A377BF', alpha_points, bgPmenu), fg = '#A377BF' })
    vim.api.nvim_set_hl(0, 'CmpItemKindClass', { bg = blend('#A377BF', alpha_points, bgPmenu), fg = '#A377BF' })
    vim.api.nvim_set_hl(0, 'CmpItemKindModule', { bg = blend('#A377BF', alpha_points, bgPmenu), fg = '#A377BF' })
    vim.api.nvim_set_hl(0, 'CmpItemKindOperator', { bg = blend('#A377BF', alpha_points, bgPmenu), fg = '#A377BF' })
    vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = blend('#7E8294', alpha_points, bgPmenu), fg = '#7E8294' })
    vim.api.nvim_set_hl(0, 'CmpItemKindFile', { bg = blend('#7E8294', alpha_points, bgPmenu), fg = '#7E8294' })
    vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { bg = blend('#D4A959', alpha_points, bgPmenu), fg = '#D4A959' })
    vim.api.nvim_set_hl(0, 'CmpItemKindSnippet', { bg = blend('#D4A959', alpha_points, bgPmenu), fg = '#D4A959' })
    vim.api.nvim_set_hl(0, 'CmpItemKindFolder', { bg = blend('#D4A959', alpha_points, bgPmenu), fg = '#D4A959' })
    vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { bg = blend('#6C8ED4', alpha_points, bgPmenu), fg = '#6C8ED4' })
    vim.api.nvim_set_hl(0, 'CmpItemKindValue', { bg = blend('#6C8ED4', alpha_points, bgPmenu), fg = '#6C8ED4' })
    vim.api.nvim_set_hl(0, 'CmpItemKindEnumMember', { bg = blend('#6C8ED4', alpha_points, bgPmenu), fg = '#6C8ED4' })
    vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { bg = blend('#58B5A8', alpha_points, bgPmenu), fg = '#58B5A8' })
    vim.api.nvim_set_hl(0, 'CmpItemKindColor', { bg = blend('#58B5A8', alpha_points, bgPmenu), fg = '#58B5A8' })
    vim.api.nvim_set_hl(0, 'CmpItemKindTypeParameter', {
      bg = blend('#58B5A8', alpha_points, bgPmenu),
      fg = '#58B5A8',
    })
  else
    vim.api.nvim_set_hl(0, 'CmpItemKindField', { fg = '#EED8DA', bg = '#B5585F' })
    vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { fg = '#EED8DA', bg = '#B5585F' })
    vim.api.nvim_set_hl(0, 'CmpItemKindEvent', { fg = '#EED8DA', bg = '#B5585F' })
    vim.api.nvim_set_hl(0, 'CmpItemKindText', { fg = '#C3E88D', bg = '#9FBD73' })
    vim.api.nvim_set_hl(0, 'CmpItemKindEnum', { fg = '#C3E88D', bg = '#9FBD73' })
    vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { fg = '#C3E88D', bg = '#9FBD73' })
    vim.api.nvim_set_hl(0, 'CmpItemKindConstant', { fg = '#FFE082', bg = '#D4BB6C' })
    vim.api.nvim_set_hl(0, 'CmpItemKindConstructor', { fg = '#FFE082', bg = '#D4BB6C' })
    vim.api.nvim_set_hl(0, 'CmpItemKindReference', { fg = '#FFE082', bg = '#D4BB6C' })
    vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { fg = '#EADFF0', bg = '#A377BF' })
    vim.api.nvim_set_hl(0, 'CmpItemKindStruct', { fg = '#EADFF0', bg = '#A377BF' })
    vim.api.nvim_set_hl(0, 'CmpItemKindClass', { fg = '#EADFF0', bg = '#A377BF' })
    vim.api.nvim_set_hl(0, 'CmpItemKindModule', { fg = '#EADFF0', bg = '#A377BF' })
    vim.api.nvim_set_hl(0, 'CmpItemKindOperator', { fg = '#EADFF0', bg = '#A377BF' })
    vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { fg = '#C5CDD9', bg = '#7E8294' })
    vim.api.nvim_set_hl(0, 'CmpItemKindFile', { fg = '#C5CDD9', bg = '#7E8294' })
    vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { fg = '#F5EBD9', bg = '#D4A959' })
    vim.api.nvim_set_hl(0, 'CmpItemKindSnippet', { fg = '#F5EBD9', bg = '#D4A959' })
    vim.api.nvim_set_hl(0, 'CmpItemKindFolder', { fg = '#F5EBD9', bg = '#D4A959' })
    vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { fg = '#DDE5F5', bg = '#6C8ED4' })
    vim.api.nvim_set_hl(0, 'CmpItemKindValue', { fg = '#DDE5F5', bg = '#6C8ED4' })
    vim.api.nvim_set_hl(0, 'CmpItemKindEnumMember', { fg = '#DDE5F5', bg = '#6C8ED4' })
    vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { fg = '#D8EEEB', bg = '#58B5A8' })
    vim.api.nvim_set_hl(0, 'CmpItemKindColor', { fg = '#D8EEEB', bg = '#58B5A8' })
    vim.api.nvim_set_hl(0, 'CmpItemKindTypeParameter', { fg = '#D8EEEB', bg = '#58B5A8' })
  end
end

colorize_cmp()

vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
  callback = colorize_cmp,
})
