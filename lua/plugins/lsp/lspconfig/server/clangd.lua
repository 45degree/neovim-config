local clangd_flags = {
  '--all-scopes-completion',
  '--background-index',
  '--pch-storage=disk',
  '--log=info',
  '--completion-style=detailed',
  '--enable-config', -- clangd 11+ supports reading from .clangd configuration file
  '--clang-tidy',
  '--header-insertion-decorators',
  -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
  -- "--fallback-style=Google",
  -- "--header-insertion=never",
  -- "--query-driver=<list-of-white-listed-complers>"
}

return function(opts)
  opts.capabilities.offsetEncoding = 'utf-16'

  opts.cmd = {
    'clangd',
    unpack(clangd_flags),
  }

  opts.init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  }

  return opts
end
