local component = require('lualine.component'):extend()

local function get_active_lsp_name()
  local clients = vim.lsp.get_clients()
  local buf = vim.api.nvim_get_current_buf()
  clients = vim
    .iter(clients)
    :filter(function(client)
      return client.attached_buffers[buf]
    end)
    :filter(function(client)
      return client.name ~= 'copilot'
    end)
    :map(function(client)
      return client.name
    end)
    :totable()
  return table.concat(clients, ' ')
end

local function get_dap_status()
  ---@diagnostic disable-next-line: redefined-local
  local dap = package.loaded['dap']
  if dap then
    return dap.status()
  end
  return ''
end

function component:init(options)
  component.super.init(self, options)
end

function component:update_status()
  local dap_status = get_dap_status()
  if dap_status ~= '' then
    return '  ' .. dap_status
  end

  local lsp_status = get_active_lsp_name()
  if lsp_status ~= '' then
    return '  ' .. lsp_status
  end

  return ''
end

return component
