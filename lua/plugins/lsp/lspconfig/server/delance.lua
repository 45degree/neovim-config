local root_files = {
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  'Pipfile',
  'pyrightconfig.json',
  '.git',
}

return function(opts)
  opts.cmd = { 'delance-langserver.cmd', '--stdio' }
  opts.filetypes = { 'python' }
  opts.single_file_support = true
  opts.root_dir = function(fname) return require('lspconfig.util').root_pattern(unpack(root_files))(fname) end
  opts.settings = {
    python = {
      analysis = {
        typeCheckingMode = 'basic',
        diagnosticMode = 'openFilesOnly',
        stubPath = './typings',
        autoSearchPaths = true,
        extraPaths = {},
        diagnosticSeverityOverrides = {},
        useLibraryCodeForTypes = true,
      },
    },
  }
  return opts
end
