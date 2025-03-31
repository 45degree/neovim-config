---- close all buffer that not visible and not pined
local function close_all_but_visible_and_pin_buf()
  local state = require('bufferline.state')
  local render = require('bufferline.render')
  local Buffer = require('bufferline.buffer')
  local bbye = require('bufferline.bbye')

  for _, bufnr in ipairs(state.buffers) do
    if Buffer.get_activity(bufnr) < 2 and not state.is_pinned(bufnr) then bbye.bdelete(false, bufnr) end
  end

  render.update()
end

return {
  'romgrk/barbar.nvim',
  event = 'LazyFile',
  keys = {
    { '<leader>bj', '<cmd>BufferPick<cr>', desc = 'jump between buffers' },
    { '<leader>bp', '<cmd>BufferPin<cr>', desc = 'pin buffer' },
    { '<leader>bdc', '<cmd>BufferPickDelete<cr>', desc = 'choose buffer delete' },
    { '<leader>bdv', close_all_but_visible_and_pin_buf, desc = 'close all buffer not visible and not pinned' },
  },
  opts = {
    -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
    hide = { extensions = false, inactive = false },
    icons = {
      -- Enables / disables diagnostic symbols
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = require('icons').diagnostic.error },
        [vim.diagnostic.severity.WARN] = { enabled = true, icon = require('icons').diagnostic.warn },
        [vim.diagnostic.severity.INFO] = { enabled = false, icon = require('icons').diagnostic.info },
        [vim.diagnostic.severity.HINT] = { enabled = false, icon = require('icons').diagnostic.hint },
      },
      gitsigns = {
        added = { enabled = false, icon = require('icons').gitsigns.added },
        changed = { enabled = false, icon = require('icons').gitsigns.modified },
        deleted = { enabled = false, icon = require('icons').gitsigns.deleted },
      },
      modified = { button = '' },
      pinned = { button = '', filename = true },
    },
    auto_hide = 0,
    exclude_ft = { 'alpha', 'snacks_dashboard' },
  },
}
