return function()
  require('render-markdown').setup({
        -- Pre configured settings that will attempt to mimic various target
    -- user experiences. Any user provided settings will take precedence.
    --  obsidian: mimic Obsidian UI
    --  lazy:     will attempt to stay up to date with LazyVim configuration
    --  none:     does nothing
    preset = 'obsidian',
    render_modes = { 'n', 'c' ,'i'},
  })
end
