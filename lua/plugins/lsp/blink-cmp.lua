---@type LazyPluginSpec
return {
  'Saghen/blink.cmp',
  version = '*',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = { 'rafamadriz/friendly-snippets', { 'L3MON4D3/LuaSnip', version = 'v2.*' }, { 'Saghen/blink.compat', version = '*', lazy = true } },
  opts = {
    keymap = {
      preset = 'default',
      ['<CR>'] = { 'accept', 'fallback' },
      ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
    },
    snippets = { preset = 'luasnip' },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev', 'avante_commands', 'avante_mentions', 'avante_files' },
      providers = {
        lazydev = { name = 'Development', module = 'lazydev.integrations.blink' },
        avante_commands = { name = 'avante_commands', module = 'blink.compat.source', score_offset = 90, opts = {} },
        avante_files = { name = 'avante_commands', module = 'blink.compat.source', score_offset = 100, opts = {} },
        avante_mentions = { name = 'avante_mentions', module = 'blink.compat.source', score_offset = 1000, opts = {} },
      },
    },
    completion = {
      list = { selection = { preselect = false, auto_insert = false } },
      ghost_text = { enabled = false },
      accept = { create_undo_point = true, auto_brackets = { enabled = false } },
      menu = {
        scrollbar = false,
        border = require('config').border,
        -- Minimum width should be controlled by components
        min_width = 1,
        draw = {
          gap = 1,
          padding = 1,
          columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'provider' } },
          components = {
            provider = { text = function(ctx) return '[' .. ctx.item.source_name:sub(1, 3):upper() .. ']' end },
            kind_icons = {
              text = function(ctx)
                -- default kind icon
                local icon = ctx.kind_icon
                -- if LSP source, check for color derived from documentation
                if ctx.item.source_name == 'LSP' then
                  local color_item = require('nvim-highlight-colors').format(ctx.item.documentation, { kind = ctx.kind })
                  if color_item and color_item.abbr then icon = color_item.abbr end
                end
                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                -- default highlight group
                local highlight = 'BlinkCmpKind' .. ctx.kind
                -- if LSP source, check for color derived from documentation
                if ctx.item.source_name == 'LSP' then
                  local color_item = require('nvim-highlight-colors').format(ctx.item.documentation, { kind = ctx.kind })
                  if color_item and color_item.abbr_hl_group then highlight = color_item.abbr_hl_group end
                end
                return highlight
              end,
            },
          },
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
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'mono',
      kind_icons = require('icons').kind,
    },
  },
}
