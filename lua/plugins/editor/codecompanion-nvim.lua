local config = require('config')

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
      ---@type CodeCompanion.Schema
      temperature = {
        order = 2,
        mapping = 'parameters',
        type = 'number',
        optional = true,
        default = 0.0,
        desc = 'What sampling temperature to use, between 0 and 1.',
        validate = function(n) return n >= 0 and n <= 1, 'Must be between 0 and 1' end,
      },
      ---@type CodeCompanion.Schema
      top_p = {
        order = 3,
        mapping = 'parameters',
        type = 'number',
        optional = true,
        default = 0.95,
        desc = 'Another sampling method, i.e. the model considers the result of a tag with a probability mass of top_p',
        validate = function(n) return n >= 0 and n <= 1, 'Must be between 0 and 1' end,
      },
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
      ---@type CodeCompanion.Schema
      temperature = {
        order = 2,
        mapping = 'parameters',
        type = 'number',
        optional = true,
        default = 0.0,
        desc = 'What sampling temperature to use, between 0 and 1.',
        validate = function(n) return n >= 0 and n <= 1, 'Must be between 0 and 1' end,
      },
      ---@type CodeCompanion.Schema
      top_p = {
        order = 3,
        mapping = 'parameters',
        type = 'number',
        optional = true,
        default = 0.95,
        desc = 'Another sampling method, i.e. the model considers the result of a tag with a probability mass of top_p',
        validate = function(n) return n >= 0 and n <= 1, 'Must be between 0 and 1' end,
      },
    },
  })
end

local claude_code_adapter = function()
  return require('codecompanion.adapters').extend('claude_code', {
    commands = { default = { 'bunx', '--silent', '--yes', '@zed-industries/claude-code-acp' } },
  })
end

return {
  'olimorris/codecompanion.nvim',
  cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionCmd', 'CodeCompanionActions', 'CodeCompanionHistory', 'CodeCompanionSummaries' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    { dir = vim.fn.stdpath('config') .. '/codecompanion-progress.nvim' },
  },
  keys = {
    { '<leader>aa', '<cmd>CodeCompanionChat<cr>', desc = 'Add CodeCompanion Chat', mode = { 'n', 'v' } },
    { '<leader>at', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'Toggle CodeCompanion Chat', mode = { 'n', 'v' } },
    { '<leader>ah', '<cmd>CodeCompanionHistory<cr>', desc = 'CodeCompanion Chat History' },
    { '<leader>ac', '<cmd>CodeCompanionActions<cr>', desc = 'CodeCompanion Chat Actions', mode = { 'n', 'v' } },
    { '<leader>ai', '<cmd>CodeCompanion<cr>', desc = 'CodeCompanion Inline', mode = { 'n', 'v' } },
  },
  init = function() vim.cmd([[cab cc CodeCompanion]]) end,
  opts = function(_, opts)
    local default = {
      adapters = {
        http = {
          moonshot = moonshot_adapter,
          bigmodel = bigmodel_adapter,
        },
      },
      strategies = {
        chat = {
          adapter = config.codecompanion_adapter.chat,
          roles = {
            ---@param adapter CodeCompanion.HTTPAdapter|CodeCompanion.ACPAdapter
            llm = function(adapter)
              if adapter.model == nil then return string.format('%s', adapter.formatted_name) end
              return string.format('(%s) %s', adapter.formatted_name, adapter.model.name)
            end,
          },
        },
        inline = { adapter = config.codecompanion_adapter.inline },
        cmd = { adapter = config.codecompanion_adapter.cmd },
      },
      opts = { language = 'Chinese' },
      display = { chat = { window = { position = 'right', width = 0.3, opts = { number = false, relativenumber = false, winfixwidth = true } } } },
      extensions = {
        progress = {
          opts = {
            spinner = { enabled = false, symbols = require('util.spinners').zip },
            notify = { symbols = require('util.spinners').bouncing_bar },
          },
        },
      },
    }

    if vim.fn.executable('claude') == 1 and vim.fn.executable('claude-code-acp') == 1 then
      default.adapters.acp = default.adapters.acp or {}
      default.adapters.acp.claude_code = claude_code_adapter
    end

    if vim.fn.executable('mcp-hub') == 1 then
      default.extensions.mcphub = {
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
      }
    end

    if vim.fn.executable('vectorcode') == 1 then default.extensions.vectorcode = { enabled = true } end

    opts = vim.tbl_deep_extend('force', default, opts)
    return opts
  end,
}
