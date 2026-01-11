local config = require('config')

local moonshot_adapter = function()
  return require('codecompanion.adapters').extend('openai_compatible', {
    formatted_name = 'moonshot',
    env = {
      url = 'https://api.moonshot.cn',
      api_key = config.api_keys.MOONSHOT_API_KEY,
      chat_url = '/v1/chat/completions',
    },
    schema = {
      model = { default = 'kimi-k2-thinking' },
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
      url = 'https://open.bigmodel.cn/api/coding/paas',
      api_key = config.api_keys.BIGMODEL_API_KEY,
      chat_url = '/v4/chat/completions',
    },
    schema = {
      model = {
        default = 'glm-4.7',
        choices = {
          ['glm-4.7'] = {
            formatted_name = 'GLM-4.7',
            opts = { can_reason = true, has_vision = false },
          },
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

local get_mcp_servers_for_acp = function()
  local mcpServers = {}

  if vim.fn.executable('bunx') == 1 then
    table.insert(mcpServers, { name = 'context7', command = 'bunx', args = { '-y', '@upstash/context7-mcp' }, env = {} })

    if vim.env.TAVILY_API_KEY ~= vim.NIL then
      table.insert(mcpServers, {
        name = 'tavily-remote-mcp',
        command = 'bunx',
        args = { '-y', 'mcp-remote', 'https://mcp.tavily.com/mcp/?tavilyApiKey=${TAVILY_API_KEY}' },
        env = { { name = 'TAVILY_API_KEY', value = config.api_keys.TAVILY_API_KEY } },
      })
    end

    if vim.env.GITHUB_PERSONAL_ACCESS_TOKEN ~= vim.NIL then
      table.insert(mcpServers, {
        name = 'github',
        command = 'bunx',
        args = { '-y', '@modelcontextprotocol/server-github' },
        env = { { name = 'GITHUB_PERSONAL_ACCESS_TOKEN', value = config.api_keys.GITHUB_PERSONAL_ACCESS_TOKEN } },
      })
    end
  end

  return mcpServers
end

local claude_code_adapter = function()
  return require('codecompanion.adapters').extend('claude_code', {
    commands = { default = { 'bunx', '--silent', '--yes', '@zed-industries/claude-code-acp' } },
    defaults = { mcpServers = get_mcp_servers_for_acp() },
  })
end

local kimi_cli_adapter = function()
  local adapter = require('codecompanion.adapters').extend('kimi_cli', {
    defaults = { mcpServers = get_mcp_servers_for_acp() },
  })

  return adapter
end

local opencode_adapter = function()
  return require('codecompanion.adapters').extend('opencode', {
    defaults = { mcpServers = get_mcp_servers_for_acp() },
  })
end

return {
  'olimorris/codecompanion.nvim',
  cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionCmd', 'CodeCompanionActions' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    { dir = vim.fn.stdpath('config') .. '/codecompanion-progress.nvim' },
  },
  keys = {
    { '<leader>aa', '<cmd>CodeCompanion<cr>', desc = 'CodeCompanion Inline', mode = { 'n', 'v' } },
    { '<leader>an', '<cmd>CodeCompanionChat<cr>', desc = 'New CodeCompanion Chat', mode = { 'n', 'v' } },
    { '<leader>at', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'Toggle CodeCompanion Chat', mode = { 'n', 'v' } },
    { '<leader>ac', '<cmd>CodeCompanionActions<cr>', desc = 'CodeCompanion Chat Actions', mode = { 'n', 'v' } },
  },
  init = function() vim.cmd([[cab cc CodeCompanion]]) end,
  opts = function(_, opts)
    local default = {
      adapters = { http = {} },
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
            notify = { symbols = require('util.spinners').dots },
          },
        },
      },
    }

    if config.api_keys.BIGMODEL_API_KEY ~= vim.NIL then default.adapters.http.bigmodel = bigmodel_adapter() end
    if config.api_keys.MOONSHOT_API_KEY ~= vim.NIL then default.adapters.http.moonshot = moonshot_adapter() end

    if vim.fn.executable('claude') == 1 and vim.fn.executable('claude-code-acp') == 1 then
      default.adapters.acp = default.adapters.acp or {}
      default.adapters.acp.claude_code = claude_code_adapter
    end

    if vim.fn.executable('kimi') == 1 and vim.env.KIMI_CLI_API_KEY ~= vim.NIL then
      default.adapters.acp = default.adapters.acp or {}
      default.adapters.acp.kimi_cli = kimi_cli_adapter
    end

    if vim.fn.executable('opencode') == 1 then
      default.adapters.acp = default.adapters.acp or {}
      default.adapters.acp.opencode = opencode_adapter
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
