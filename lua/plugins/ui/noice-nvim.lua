return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
  opts = {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = false,
      },
      hover = { enabled = true },
      signature = { enabled = true },
    },
    messages = {
      enabled = true, -- enables the Noice messages UI
      view = 'mini', -- default view for messages
      view_error = 'mini', -- view for errors
      view_warn = 'mini', -- view for warnings
      view_history = 'messages', -- view for :messages
      view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
    },
    routes = {},
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
      lsp_doc_border = true,
    },
    views = {
      cmdline_popup = { border = { style = require('config').border } },
      hover = { border = { style = require('config').border } },
    },
  },
  config = function(_, opts)
    local icons = require('icons')
    require('notify').setup({
      icons = {
        DEBUG = icons.diagnostic.bug,
        ERROR = icons.diagnostic.error,
        INFO = icons.diagnostic.info,
        TRACE = icons.diagnostic.hint,
        WARN = icons.diagnostic.warn,
      },
    })

    require('noice').setup(opts)
  end,
}
