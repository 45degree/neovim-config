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

    ensure_install({ 'cpp', 'c', 'comment', 'doxygen', 'json', 'vim', 'lua', 'bash' })
    ensure_install({ 'latex', 'typst', 'markdown', 'markdown_inline' })
    ensure_install({ 'css', 'html', 'javascript', 'tsx', 'scss', 'svelte', 'vue', 'yaml', 'toml' })

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
