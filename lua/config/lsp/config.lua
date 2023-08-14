vim.diagnostic.config({
  virtual_text = {
    prefix = '',
    sources = 'always',
  },
  float = {
    sources = 'always',
  },
  update_in_insert = false,
})

vim.lsp.handlers['textDocument/hover'] = function(err, result, ctx, config)
  -- if not result or not result.contents then
  --   vim.notify('No information available')
  --   return
  -- end
  --
  -- -- MarkedString | MarkedString[] | MarkupContent;
  -- -- type MarkedString = string | { language: string; value: string };
  -- -- interface MarkupContent { kind: MarkupKind; value: string; }
  -- local value
  -- if type(result.contents) == 'string' then -- MarkedString
  --   value = result.contents
  -- elseif result.contents.language then -- MarkedString
  --   value = result.contents.value
  -- elseif vim.tbl_islist(result.contents) then -- MarkedString[]
  --   if vim.tbl_isempty(result.contents) then
  --     vim.notify('No information available')
  --     return
  --   end
  --   local values = {}
  --   for _, ms in ipairs(result.contents) do
  --     ---@diagnostic disable-next-line: undefined-field
  --     table.insert(values, type(ms) == 'string' and ms or ms.value)
  --   end
  --   value = table.concat(values, '\n')
  -- elseif result.contents.kind then -- MarkupContent
  --   value = result.contents.value
  -- end
  --
  -- if not value or #value == 0 then
  --   vim.notify('No information available')
  --   return
  -- end
  -- local content = vim.split(value, '\n', { trimempty = true })
  --
  -- print(#content)
  -- print(vim.inspect(content))
  -- local height = math.min(30, #content)

  vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })(err, result, ctx, config)
end

--- In lsp attach function
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions theme=dropdown<cr>', opts)
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations theme=dropdown<cr>', opts)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>Telescope lsp_references theme=dropdown<cr>', opts)
vim.api.nvim_set_keymap('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
vim.api.nvim_set_keymap('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
