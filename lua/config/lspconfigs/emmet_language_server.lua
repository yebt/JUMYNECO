  local emmet_filetypes = { 'css', 'eruby', 'html', 'htmldjango', 'javascriptreact', 'less', 'pug', 'sass', 'scss',
    'typescriptreact', 'htmlangular', 'blade', 'php', 'vue', 'jsx', 'smarty', 'tpl', 'twig', }

-- NOTE: this is a better option, show abrebiations here
return {
  filetypes = emmet_filetypes,
  init_options = {
    showAbbreviationSuggestions = true,
    -- showExpandedAbbreviation = 'always',
    showSuggestionsAsSnippets = true,
  },
}
