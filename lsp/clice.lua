return {
  cmd = { 'clice', 'serve' },
  filetypes = { 'c', 'cpp' },
  root_markers = {
    '.git/',
    'clice.toml',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac',
  },
}
