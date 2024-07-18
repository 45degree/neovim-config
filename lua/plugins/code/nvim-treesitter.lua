return {
  'nvim-treesitter/nvim-treesitter',
  event = 'VeryLazy',
  dependencies = { 'nushell/tree-sitter-nu' },
  config = function()
    local ignoreLang = {}
    if vim.fn.has('WIN32') then
      table.insert(ignoreLang, 'rnoweb')
      table.insert(ignoreLang, 'ocaml')
      table.insert(ignoreLang, 'ocaml_interface')
      table.insert(ignoreLang, 'systemverilog')
    end

    ---@diagnostic disable-next-line: inject-field
    require('nvim-treesitter.parsers').get_parser_configs().nu = {
      install_info = {
        url = 'https://github.com/nushell/tree-sitter-nu',
        files = { 'src/parser.c' },
        branch = 'main',
      },
      filetype = 'nu',
    }

    require('nvim-treesitter.configs').setup({
      ensure_installed = 'all',
      sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
      auto_install = false,
      modules = {},
      ignore_install = ignoreLang, -- List of parsers to ignore installing
      highlight = {
        enable = true, -- false will disable the whole extension
        disable = function(lang, buf)
          -- if the file is too large, disable highlight
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then return true end

          -- if the buf has an attached lsp expected null-ls, disable highlight
          local clients = vim.lsp.get_clients({ bufnr = buf })
          for _, client in ipairs(clients) do
            if client.server_capabilities['semanticTokensProvider'] then return true end
          end
          return false
        end,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
    })
  end,
}
