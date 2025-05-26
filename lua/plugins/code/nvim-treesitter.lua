return {
  'nvim-treesitter/nvim-treesitter',
  event = 'LazyFile',
  cmd = { 'TSUpdate', 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
  branch = 'main',
  opts = { install_dir = vim.fn.stdpath('data') .. '/site' },
  config = function(_, opts)
    require('nvim-treesitter.parsers').haxe = {
      install_info = {
        url = 'https://github.com/vantreeseba/tree-sitter-haxe',
        files = { 'src/parser.c', 'src/scanner.c' },
        branch = 'main',
      },
      filetype = 'haxe',
    }
    require('nvim-treesitter').setup(opts)

    vim.api.nvim_create_autocmd('BufEnter', {
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local parser = vim.treesitter.get_parser(buf, nil, { error = false })
        if parser == nil then return end

        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          vim.treesitter.stop(buf)
          return
        end

        local clients = vim.lsp.get_clients({ bufnr = buf })
        for _, client in ipairs(clients) do
          if client.server_capabilities['semanticTokensProvider'] then
            vim.treesitter.stop(buf)
            return
          end
        end
        vim.treesitter.start(buf)
      end,
    })
  end,
}
