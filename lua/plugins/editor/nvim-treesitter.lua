---@param langs string[]
local function ensure_install(langs)
  local installed = require('nvim-treesitter').get_installed()
  local uninstalled_lang = {}
  for _, lang in ipairs(langs) do
    if not vim.tbl_contains(installed, lang) then table.insert(uninstalled_lang, lang) end
  end

  if #uninstalled_lang ~= 0 then require('nvim-treesitter').install(uninstalled_lang) end
end

return {
  'nvim-treesitter/nvim-treesitter',
  event = 'LazyFile',
  cmd = { 'TSUpdate', 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
  branch = 'main',
  opts = { install_dir = vim.fn.stdpath('data') .. '/site' },
  config = function(_, opts)
    require('nvim-treesitter').setup(opts)

    ensure_install({ 'cpp', 'c', 'comment', 'json', 'vim', 'lua', 'bash' })
    ensure_install({ 'latex', 'typst', 'markdown', 'markdown_inline' })
    ensure_install({ 'css', 'html', 'javascript', 'tsx', 'scss', 'svelte', 'vue', 'yaml', 'toml' })

    vim.api.nvim_create_autocmd('BufEnter', {
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local methods = vim.lsp.protocol.Methods
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
          if client:supports_method(methods.textDocument_semanticTokens_full) then
            vim.treesitter.stop(buf)
            return
          end
        end
        vim.treesitter.start(buf)
      end,
    })
  end,
}
