return {
  'yetone/avante.nvim',
  lazy = true,
  event = 'LazyFile',
  cmd = {
    'AvanteAsk',
    'AvanteBuild',
    'AvanteChat',
    'AvanteEdit',
    'AvanteFocus',
    'AvanteRefresh',
    'AvanteSwitchProvider',
    'AvanteShowRepoMap',
    'AvanteToggle',
  },
  build = ':AvanteBuild',
  version = '*',
  keys = function(_, keys)
    ---@type avante.Config
    local opts = require('lazy.core.plugin').values(require('lazy.core.config').spec.plugins['avante.nvim'], 'opts', false)

    local mappings = {
      {
        opts.mappings.ask,
        function() require('avante.api').ask() end,
        desc = 'avante: ask',
        mode = { 'n', 'v' },
      },
      {
        opts.mappings.refresh,
        function() require('avante.api').refresh() end,
        desc = 'avante: refresh',
        mode = 'v',
      },
      {
        opts.mappings.edit,
        function() require('avante.api').edit() end,
        desc = 'avante: edit',
        mode = { 'n', 'v' },
      },
    }
    mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)
    return vim.list_extend(mappings, keys)
  end,
  opts = {
    -- add any opts here
    provider = 'copilot', -- You can then change this provider here
    gemini = { api_key_name = 'GEMINI_API_KEY' },
    vendors = {
      kimi = {
        __inherited_from = 'openai',
        api_key_name = 'KIMI_API_KEY',
        endpoint = 'https://api.moonshot.cn/v1',
        model = 'moonshot-v1-8k',
      },
      deepseek = {
        __inherited_from = 'openai',
        api_key_name = 'DEEPSEEK_API_KEY',
        endpoint = 'https://api.deepseek.com',
        model = 'deepseek-coder',
      },
    },
    mappings = {
      ask = '<leader>aa',
      edit = '<leader>ae',
      refresh = '<leader>ar',
    },
  },
}
