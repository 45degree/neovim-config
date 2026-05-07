return {
  'romus204/tree-sitter-manager.nvim',
  event = 'LazyFile',
  cmd = 'TSManager',
  opts = { auto_install = true },
  config = function(_, opts)
    local ensure_installed = {
      opts.ensure_installed or {},
      { 'cpp', 'c', 'comment', 'doxygen', 'json', 'vim', 'lua', 'bash' },
      { 'latex', 'typst', 'markdown', 'markdown_inline' },
      { 'css', 'html', 'javascript', 'tsx', 'scss', 'svelte', 'vue', 'yaml', 'toml' },
    }
    opts.ensure_installed = vim.iter(ensure_installed):flatten():totable()

    require('tree-sitter-manager').setup(opts)
    vim.api.nvim_create_autocmd('FileType', {
      desc = 'Enable treesitter-based features for supported filetypes',
      callback = function(args)
        local bufnr = args.buf
        local filetype = args.match
        local lang = vim.treesitter.language.get_lang(filetype)
        if lang and vim.treesitter.language.add(lang) then vim.treesitter.start(bufnr, lang) end
      end,
    })
  end,
}
