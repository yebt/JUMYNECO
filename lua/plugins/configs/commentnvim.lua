return function()
  local opts = {
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
      ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
      basic = true,
      ---Extra mapping; `gco`, `gcO`, `gcA`
      extra = true,
    },
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
      ---Line-comment toggle keymap
      line = 'gcc',
      ---Block-comment toggle keymap
      block = 'gbc',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
      ---Line-comment keymap
      line = 'gc',
      ---Block-comment keymap
      block = 'gb',
    },
    ---LHS of extra mappings
    extra = {
      ---Add comment on the line above
      above = 'gcO',
      ---Add comment on the line below
      below = 'gco',
      ---Add comment at the end of line
      eol = 'gcA',
    },
    ---Function to call before (un)comment
    pre_hook = nil,
    -- pre_hook = function(ctx)
    --   local commentstring = require("ts-comments.comments").get(vim.bo.filetype)
    --   return commentstring
    -- end,
    ---Lines to be ignored while (un)comment
    ignore = nil,
    -- pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    ---Function to call after (un)comment
    post_hook = nil,
  }
  -- local ok, tscc = pcall(require, 'ts-comments.comments')
  -- if ok then
  --   opts.pre_hook = function (ctx)
  --     return tscc.get(vim.bo.filetype)
  --   end
  -- end

  local okt, ntcc = pcall(require, 'ts_context_commentstring.integrations.comment_nvim');
  if  okt then
    opts.post_hook =  ntcc.create_pre_hook()
  end

  require('Comment').setup(opts)
end
