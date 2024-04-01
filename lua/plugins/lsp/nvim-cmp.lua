local function setup_nvim_cmp()
  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end
  local cmp = require('cmp')
  local luasnip = require('luasnip')

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    enabled = function()
      return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt' or require('cmp_dap').is_dap_buffer()
    end,
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = {
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- they way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
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
    }, {
      { name = 'buffer' },
      { name = 'path' },
      { name = 'nvim_lua' },
    }),
    matching = {
      disallow_fuzzy_matching = true,
      disallow_fullfuzzy_matching = true,
      disallow_partial_fuzzy_matching = false,
      disallow_partial_matching = false,
      disallow_prefix_unmatching = true,
    },
    sorting = {
      priority_weight = 1.0,
      comparators = {
        -- compare.score_offset, -- not good at all
        cmp.config.compare.locality,
        cmp.config.compare.recently_used,
        cmp.config.compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
        cmp.config.compare.offset,
        cmp.config.compare.order,
        -- compare.scopes, -- what?
        -- compare.sort_text,
        -- compare.exact,
        -- compare.kind,
        -- compare.length, -- useless
      },
    },
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(entry, vim_item)
        local lspkind_icons = require('icons').kind

        local menus = {
          -- cmp_tabnine = "[TN]",
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
        if string.len(vim_item.abbr) > max_len then
          vim_item.abbr = string.sub(vim_item.abbr, 1, max_len - 2) .. '··'
        end

        -- load lspkind icons
        vim_item.menu = string.format('%s %s', menus[entry.source.name], vim_item.kind)
        vim_item.kind = lspkind_icons[vim_item.kind]
        return vim_item
      end,
    },
  })

  -- config for command line
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })

  cmp.setup.cmdline('?', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      {
        name = 'cmdline',
        option = {
          ignore_cmds = { 'Man', '!' },
        },
      },
    }),
  })
end

return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-buffer',   --从buffer中智能提示
    'hrsh7th/cmp-nvim-lua', --nvim-cmp source for neovim Lua API.
    'hrsh7th/cmp-path',     --自动提示硬盘上的文件
    'ray-x/lsp_signature.nvim',
    'hrsh7th/cmp-cmdline',
  },
  config = function()
    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_vscode').lazy_load({ paths = { vim.fn.stdpath('config') .. '/vscode-snippets' } })
    require('luasnip.loaders.from_snipmate').lazy_load({ paths = { vim.fn.stdpath('config') .. '/snippets' } })
    -- require('config.plugins.nvim-cmp')
    setup_nvim_cmp()
    require('lsp_signature').setup({ hint_prefix = '󰷼 ' })
  end,
}
