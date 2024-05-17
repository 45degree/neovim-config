return {
  'numToStr/Comment.nvim',
  event = "VeryLazy",
  config = function()
    require('Comment').setup({
      pre_hook = function(...)
        return require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()(...)
      end,
    })
  end,
}
