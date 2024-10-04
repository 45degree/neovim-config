local function setup_nvim_cmp()
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  local config = require('config')

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args) require('luasnip').lsp_expand(args.body) end,
    },
    window = {
      completion = cmp.config.window.bordered({ border = config.border }),
      documentation = cmp.config.window.bordered({ border = config.border }),
    },
    mapping = {
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.jump(1)
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'lazydev' },
    }, {
      { name = 'path' },
      { name = 'nvim_lua' },
    }),
    sorting = {
      priority_weight = 1.0,
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        -- cmp.config.compare.scopes,
        cmp.config.compare.score,
        require('cmp-under-comparator').under,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        -- cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(entry, vim_item)
        local lspkind_icons = require('icons').kind

        local menus = {
          buffer = '[BUF]',
          orgmode = '[ORG]',
          nvim_lsp = '[LSP]',
          nvim_lua = '[LUA]',
          path = '[PATH]',
          tmux = '[TMUX]',
          luasnip = '[SNIP]',
          utilsnips = '[SNIP]',
          spell = '[SPELL]',
          cmdline = '[CMD]',
        }

        local max_len = 20
        if string.len(vim_item.abbr) > max_len then vim_item.abbr = string.sub(vim_item.abbr, 1, max_len - 2) .. '··' end

        -- load lspkind icons
        vim_item.menu = string.format('%s %s', menus[entry.source.name], vim_item.kind)
        vim_item.kind = lspkind_icons[vim_item.kind]
        return vim_item
      end,
    },
  })

  -- config for command line
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
      { name = 'cmdline' },
    }),
    matching = { disallow_symbol_nonprefix_matching = false },
  })
end

return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'lukas-reineke/cmp-under-comparator',
  },
  config = function()
    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_vscode').lazy_load({ paths = { vim.fn.stdpath('config') .. '/vscode-snippets' } })
    require('luasnip.loaders.from_snipmate').lazy_load({ paths = { vim.fn.stdpath('config') .. '/snippets' } })
    setup_nvim_cmp()
  end,
}
