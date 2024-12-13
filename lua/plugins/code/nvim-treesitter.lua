return {
  'nvim-treesitter/nvim-treesitter',
  event = 'LazyFile',
  opts = {
    ensure_installed = 'all',
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    auto_install = false,
    modules = {},
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = function(lang, buf)
        -- if the file is too large, disable highlight
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then return true end

        -- if the buf has an attached lsp expected null-ls, disable highlight
        -- local clients = vim.lsp.get_clients({ bufnr = buf })
        -- for _, client in ipairs(clients) do
        --   if client.server_capabilities['semanticTokensProvider'] then return true end
        -- end
        return false
      end,
      additional_vim_regex_highlighting = false,
    },
  },
  config = function(_, opts) require('nvim-treesitter.configs').setup(opts) end,
}
