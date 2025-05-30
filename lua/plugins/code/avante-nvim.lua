local can_build_from_source = vim.fn.executable('cargo') == 1

local build_str = nil
if vim.fn.has('WIN32') == 1 then
  if can_build_from_source then
    build_str = 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource true'
  else
    build_str = 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
  end
else
  if can_build_from_source then
    build_str = 'make BUILD_FROM_SOURCE=true'
  else
    build_str = 'make'
  end
end

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
  build = build_str,
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
    provider = require('config').avante_default_provider or 'copilot',
    gemini = { api_key_name = 'GEMINI_API_KEY' },
    vendors = {
      kimi = {
        __inherited_from = 'openai',
        api_key_name = 'KIMI_API_KEY',
        endpoint = 'https://api.moonshot.cn/v1',
        model = 'moonshot-v1-8k',
        temperature = 0.3,
      },
      deepseek = {
        __inherited_from = 'openai',
        api_key_name = 'DEEPSEEK_API_KEY',
        endpoint = 'https://api.deepseek.com/v1',
        model = 'deepseek-chat',
      },
      siliconflow = {
        __inherited_from = 'openai',
        api_key_name = 'SILICONFLOW_API_KEY',
        endpoint = 'https://api.siliconflow.cn/v1/',
        model = 'Pro/deepseek-ai/DeepSeek-R1',
      },
      ['siliconflow-deepseek-v2.5'] = {
        __inherited_from = 'openai',
        api_key_name = 'SILICONFLOW_API_KEY',
        endpoint = 'https://api.siliconflow.cn/v1/',
        model = 'deepseek-ai/DeepSeek-V2.5',
      },
      ['siliconflow-deepseek-v3'] = {
        __inherited_from = 'openai',
        api_key_name = 'SILICONFLOW_API_KEY',
        endpoint = 'https://api.siliconflow.cn/v1/',
        model = 'deepseek-ai/DeepSeek-V3',
      },
      ['siliconflow-deepseek-r1-distill-llama-70B'] = {
        __inherited_from = 'openai',
        api_key_name = 'SILICONFLOW_API_KEY',
        endpoint = 'https://api.siliconflow.cn/v1/',
        model = 'deepseek-ai/DeepSeek-R1-Distill-Llama-70B',
      },
      ['siliconflow-deepseek-r1-distill-qwen-32B'] = {
        __inherited_from = 'openai',
        api_key_name = 'SILICONFLOW_API_KEY',
        endpoint = 'https://api.siliconflow.cn/v1/',
        model = 'deepseek-ai/DeepSeek-R1-Distill-Qwen-32B',
      },
    },
    mappings = {
      ask = '<leader>aa',
      edit = '<leader>ae',
      refresh = '<leader>ar',
    },
    windows = {
      sidebar_header = { rounded = false },
      edit = { border = require('config').border },
    },
  },
}
