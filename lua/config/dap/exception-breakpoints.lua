local M = {}

---@type table<string, { available_options: dap.ExceptionBreakpointsFilter[], selected_items: integer[] }>
M.exception_options = {}

local dap = require('dap')

---@param adapter_id string
function M.set_exception_breakpoints(adapter_id)
  local entry = M.exception_options[adapter_id]
  if entry == nil then return end
  local available_options = entry.available_options
  local selected_options = vim.tbl_map(function(id) return available_options[id] end, entry.selected_items)
  local filters = vim.tbl_map(function(x) return x.filter end, selected_options)
  dap.set_exception_breakpoints(filters)
end

---@param adapter_id string
---@param filters dap.ExceptionBreakpointsFilter[]
function M.update_options(adapter_id, filters)
  M.exception_options[adapter_id] = {
    available_options = filters,
    selected_items = {},
  }
  for id, option in ipairs(filters) do
    if option.default then table.insert(M.exception_options[adapter_id].selected_items, id) end
  end
end

---@param opts { args: string }
function M.toggle(opts)
  local adapter_id = opts.args
  if adapter_id == '' then
    local session = dap.session()
    if session == nil then
      vim.notify('No active DAP session', vim.log.levels.WARN)
      return
    end
    adapter_id = session.config.type
  end
  if adapter_id == nil then return end

  local entry = M.exception_options[adapter_id]
  if entry == nil then
    vim.notify('No exception breakpoint options for adapter: ' .. adapter_id, vim.log.levels.WARN)
    return
  end

  local available_options = entry.available_options
  local selected = entry.selected_items

  local select_ui_opts = {
    ---@param item dap.ExceptionBreakpointsFilter
    ---@return string
    format_item = function(item)
      local is_selected = vim.tbl_contains(vim.tbl_map(function(x) return available_options[x].filter end, selected), item.filter)
      return (is_selected and '[x] ' or '[ ] ') .. item.filter .. (item.label and (' - ' .. item.label) or '')
    end,
    prompt = 'Toggle Exception Breakpoints (' .. adapter_id .. ')',
  }
  vim.ui.select(available_options, select_ui_opts, function(_, idx)
    if idx == nil then return end
    if not vim.list_contains(selected, idx) then table.insert(selected, idx) end

    for i, v in ipairs(selected) do
      if v == idx then
        table.remove(selected, i)
        break
      end
    end
  end)
end

return M
