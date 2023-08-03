local ignoreLang = {}
if vim.fn.has('WIN32') then
  table.insert(ignoreLang, 'rnoweb')
end

require('nvim-treesitter.configs').setup({
  ensure_installed = 'all',
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  ignore_install = ignoreLang, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = function(lang, buf)
      -- if the file is too large, disable highlight
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end

      -- if the buf has an attached lsp expected null-ls, disable highlight
      local clients = vim.lsp.get_active_clients({ bufnr = buf })
      if #clients == 0 then
        return true
      elseif #clients == 1 and clients[1].name == 'null-ls' then
        return true
      end
    end,
    -- disable = { 'c', 'cpp', 'rust' }, -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    -- list of languages you want to disable the plugin for
    -- disable = { 'jsx', 'cpp' },
    -- Which query to use for finding delimiters
    query = 'rainbow-parens',
    -- Highlight the entire buffer all at once
    strategy = require('ts-rainbow').strategy.global,
  },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
        ['ia'] = { query = '@parameter.inner', desc = 'Select inner part of a parameter region' },
        ['aa'] = '@parameter.outer',
      },
      -- You can choose the select mode (default is charwise 'v')
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding xor succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      include_surrounding_whitespace = true,
    },
  },
})
