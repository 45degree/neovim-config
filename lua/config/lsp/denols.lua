local lspconfig = require('lspconfig')

return function(opts)
  opts.root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc')

  return opts
end
