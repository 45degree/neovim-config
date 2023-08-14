local clangd_flags = {
  '--all-scopes-completion',
  '--suggest-missing-includes',
  '--background-index',
  '--pch-storage=disk',
  '--cross-file-rename',
  '--log=info',
  '--completion-style=detailed',
  '--enable-config', -- clangd 11+ supports reading from .clangd configuration file
  '--clang-tidy',
  -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
  -- "--fallback-style=Google",
  -- "--header-insertion=never",
  -- "--query-driver=<list-of-white-listed-complers>"
}

return function(opts)
  opts.capabilities.offsetEncoding = 'utf-8'

  opts.cmd = {
    'clangd',
    unpack(clangd_flags),
  }

  return opts
end
