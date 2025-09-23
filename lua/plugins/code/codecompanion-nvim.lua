local config = require('config')

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
      model = { default = 'kimi-k2-0711-preview' },
    },
  })
end

return {
  'olimorris/codecompanion.nvim',
  cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionCmd', 'CodeCompanionActions', 'CodeCompanionHistory', 'CodeCompanionSummaries' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'ravitemer/codecompanion-history.nvim',
  },
  opts = {
    adapters = {
      http = {
        siliconflow = siliconflow_adapter,
        openrouter = openrouter_adapter,
        moonshot = moonshot_adapter,
      },
    },
    strategies = {
      chat = {
        adapter = config.codecompanion_adapter.chat,
        ---@param adapter CodeCompanion.Adapter
        roles = { llm = function(adapter) return string.format('(%s) %s', adapter.formatted_name, adapter.model.name) end },
      },
      inline = { adapter = config.codecompanion_adapter.inline },
      cmd = { adapter = config.codecompanion_adapter.cmd },
    },
    opts = { language = 'Chinese' },
    display = { chat = { window = { position = 'right', width = 0.3, opts = { number = false, relativenumber = false, winfixwidth = true } } } },
    extensions = {
      history = { enabled = true },
      mcphub = {
        callback = 'mcphub.extensions.codecompanion',
        opts = {
          -- MCP Tools
          make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
          show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
          add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
          show_result_in_chat = true, -- Show tool results directly in chat buffer
          format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
          -- MCP Resources
          make_vars = true, -- Convert MCP resources to #variables for prompts
          -- MCP Prompts
          make_slash_commands = true, -- Add MCP prompts as /slash commands
        },
      },
    },
  },
}
