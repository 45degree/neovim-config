local siliconflow_adapter = function()
  return require('codecompanion.adapters').extend('openai_compatible', {
    formatted_name = 'SiliconFlow',
    env = {
      url = 'https://api.siliconflow.cn/',
      api_key = 'SILICONFLOW_API_KEY',
      chat_url = '/v1/chat/completions',
    },
    schema = {
      model = { default = 'deepseek-ai/DeepSeek-R1-Distill-Qwen-32B' },
    },
  })
end

local openrouter_adapter = function()
  return require('codecompanion.adapters').extend('openai_compatible', {
    formatted_name = 'openrouter',
    env = {
      url = 'https://openrouter.ai/api',
      api_key = 'OPENROUTER_API_KEY',
      chat_url = '/v1/chat/completions',
    },
    schema = {
      model = { default = 'deepseek/deepseek-r1-0528:free' },
    },
  })
end

local moonshot_adapter = function()
  return require('codecompanion.adapters').extend('openai_compatible', {
    formatted_name = 'moonshot',
    env = {
      url = 'https://api.moonshot.cn',
      api_key = 'KIMI_API_KEY',
      chat_url = '/v1/chat/completions',
    },
    schema = {
      model = { default = 'moonshot-v1-8k' },
    },
  })
end

return {
  'olimorris/codecompanion.nvim',
  cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionCmd', 'CodeCompanionActions' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'ravitemer/codecompanion-history.nvim',
  },
  opts = {
    adapters = {
      siliconflow = siliconflow_adapter,
      openrouter = openrouter_adapter,
      moonshot = moonshot_adapter,
    },
    strategies = {
      chat = { adapter = 'siliconflow' },
      inline = { adapter = 'siliconflow' },
    },
    opts = { language = 'Chinese' },
    display = { chat = { window = { position = 'right', width = 0.3, opts = { number = false, relativenumber = false, winfixwidth = true } } } },
    extensions = {
      history = { enabled = true },
    },
  },
}
