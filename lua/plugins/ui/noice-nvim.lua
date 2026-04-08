return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = { 'MunifTanjim/nui.nvim', 'folke/snacks.nvim' },
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
    messages = { enabled = false },
    cmdline = { enabled = false },
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
}
