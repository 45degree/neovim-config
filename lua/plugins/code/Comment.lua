return {
    'numToStr/Comment.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    version = '*',
    config = function()
      require('Comment').setup()
    end,
}
