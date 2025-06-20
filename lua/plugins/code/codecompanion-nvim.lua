local siliconflow_adapter = function()
  return require('codecompanion.adapters').extend('deepseek', {
    name = 'siliconflow',
    url = 'https://api.siliconflow.cn/v1/chat/completions',
    env = {
      api_key = function() return os.getenv('SILICONFLOW_API_KEY') end,
    },
    schema = {
      model = {
        default = 'deepseek-ai/DeepSeek-R1-Distill-Qwen-32B',
        choices = {
          ['deepseek-ai/DeepSeek-R1'] = { opts = { can_reason = true } },
          ['deepseek-ai/DeepSeek-V3'] = {},
          ['deepseek-ai/DeepSeek-R1-Distill-Qwen-32B'] = {},
          ['deepseek-ai/DeepSeek-R1-Distill-Llama-70B'] = {},
        },
      },
    },
  })
end

return {
  'olimorris/codecompanion.nvim',
  cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionCmd', 'CodeCompanionActions' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    adapters = { siliconflow = siliconflow_adapter },
    strategies = {
      chat = { adapter = 'siliconflow' },
      inline = { adapter = 'siliconflow' },
    },
    opts = { language = 'Chinese' },
    display = { chat = { window = { position = 'right', width = 0.3, opts = { number = false, relativenumber = false, winfixwidth = true } } } },
  },
}
