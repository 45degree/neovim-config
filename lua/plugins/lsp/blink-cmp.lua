---@type LazyPluginSpec
return {
  'Saghen/blink.cmp',
  build = 'cargo build --release',
  event = 'InsertEnter',
  dependencies = { 'rafamadriz/friendly-snippets', { 'L3MON4D3/LuaSnip', version = 'v2.*' } },
  opts = {
    keymap = {
      preset = 'default',
      ['<CR>'] = { 'accept', 'fallback' },
      ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
    },
    snippets = {
      expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
      active = function(filter)
        if filter and filter.direction then return require('luasnip').jumpable(filter.direction) end
        return require('luasnip').in_snippet()
      end,
      jump = function(direction) require('luasnip').jump(direction) end,
    },
    sources = {
      default = { 'lsp', 'path', 'luasnip', 'buffer', 'lazydev' },
      providers = {
        lazydev = { name = 'Development', module = 'lazydev.integrations.blink' },
      },
      cmdline = {},
    },
    completion = {
      list = { selection = 'manual' },
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
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
      kind_icons = require('icons').kind,
    },
  },
}
