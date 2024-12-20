---@type LazyPluginSpec
return {
  'Saghen/blink.cmp',
  build = 'cargo build --release',
  event = 'InsertEnter',
  dependencies = { 'rafamadriz/friendly-snippets' },
  opts = {
    keymap = {
      preset = 'default',
      ['<CR>'] = { 'accept', 'fallback' },
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
      providers = {
        lazydev = { name = 'Development', module = 'lazydev.integrations.blink' },
      },
      cmdline = {},
    },
    completion = {
      list = { selection = 'manual' },
      ghost_text = { enabled = false },
      accept = { create_undo_point = false },
      menu = {
        scrollbar = false,
        border = require('config').border,
        -- Minimum width should be controlled by components
        min_width = 1,
        draw = {
          gap = 1,
          padding = 1,
          columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'provider' } },
          components = { provider = { text = function(ctx) return '[' .. ctx.item.source_name:sub(1, 3):upper() .. ']' end } },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
        update_delay_ms = 0,
        window = {
          border = require('config').border,
          winblend = vim.o.pumblend,
          scrollbar = false,
        },
      },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
      kind_icons = require('icons').kind,
    },
  },
}
