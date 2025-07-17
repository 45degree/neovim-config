return {
  'Wansmer/symbol-usage.nvim',
  event = 'LspAttach',
  enabled = false,
  opts = {
    text_format = function(symbol)
      local fragments = {}

      -- Indicator that shows if there are any other symbols in the same line
      local stacked_functions = symbol.stacked_count > 0 and (' | +%s'):format(symbol.stacked_count) or ''

      if symbol.references then
        local usage = symbol.references <= 1 and 'usage' or 'usages'
        local num = symbol.references == 0 and 'no' or symbol.references
        table.insert(fragments, ('%s %s'):format(num, usage))
      end

      if symbol.definition then table.insert(fragments, symbol.definition .. ' defs') end

      if symbol.implementation then table.insert(fragments, symbol.implementation .. ' impls') end

      return table.concat(fragments, ', ') .. stacked_functions
    end,
  },
  init = function()
    vim.api.nvim_create_user_command('SymbolUsage', function() require('symbol-usage').toggle_globally() end, { nargs = 0 })
  end,
}
