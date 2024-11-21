local icons = require('icons')
local config = require('config')

---@type LazyPluginSpec
return {
  ---@module 'blink.cmp'
  'Saghen/blink.cmp',
  build = 'cargo build --release',
  event = 'InsertEnter',
  dependencies = { 'rafamadriz/friendly-snippets' },
  enabled = false,

  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'default',
      ['<Tab>'] = { 'select_next', 'snippet_forward', 'show', 'fallback' },
      ['<CR>'] = { 'select_and_accept', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
    },
    highlight = { use_nvim_cmp_as_default = true },
    sources = {
      completion = {
        enabled_providers = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
      },
      providers = {
        lsp = {
          name = 'LSP',
          fallback_for = { 'lazydev' },
        },
        lazydev = {
          name = 'Development',
          module = 'lazydev.integrations.blink',
        },
      },
    },
    windows = {
      autocomplete = {
        scrollbar = false,
        border = config.border,
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
        scrollbar = false,
        border = config.border,
        winblend = vim.o.pumblend,
      },
    },
    nerd_font_variant = 'mono',
    kind_icons = icons.kind,
  },
}
