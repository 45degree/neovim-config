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

local bigmodel_adapter = function()
  return require('codecompanion.adapters').extend('openai_compatible', {
    name = 'bigmodel',
    formatted_name = 'bigmodel',
    env = {
      url = 'https://open.bigmodel.cn/api/paas',
      api_key = 'BIGMODEL_API_KEY',
      chat_url = '/v4/chat/completions',
    },
    schema = {
      model = {
        default = 'glm-4.6',
        choices = {
          ['glm-4.6'] = {
            formatted_name = 'GLM-4.6',
            opts = { can_reason = true, has_vision = false },
          },
          ['glm-4.5'] = {
            formatted_name = 'GLM-4.5',
            opts = { can_reason = true, has_vision = false },
          },
          ['glm-4.5-Air'] = {
            formatted_name = 'GLM-4.5-Air',
            opts = { can_reason = true, has_vision = false },
          },
        },
      },
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
  keys = {
    { '<leader>aa', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'Toggle CodeCompanion Chat', mode = { 'n', 'v' } },
    { '<leader>ah', '<cmd>CodeCompanionHistory<cr>', desc = 'CodeCompanion Chat History' },
    { '<leader>ac', '<cmd>CodeCompanionActions<cr>', desc = 'CodeCompanion Chat Actions', mode = { 'n', 'v' } },
    { '<leader>ai', '<cmd>CodeCompanion<cr>', desc = 'CodeCompanion Inline', mode = { 'n', 'v' } },
  },
  opts = {
    adapters = {
      http = {
        siliconflow = siliconflow_adapter,
        openrouter = openrouter_adapter,
        moonshot = moonshot_adapter,
        bigmodel = bigmodel_adapter,
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
    opts = { language = 'Chinese', log_level = 'TRACE' },
    display = { chat = { window = { position = 'right', width = 0.3, opts = { number = false, relativenumber = false, winfixwidth = true } } } },
    extensions = {
      history = { enabled = true },
      spinner = {},
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
