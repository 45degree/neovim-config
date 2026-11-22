return {
  cmd = { 'neocmakelsp', 'stdio' },
  filetypes = { 'cmake' },
  root_markers = { '.neocmake.toml', '.git', 'build', 'cmake' },
  init_options = {
    format = { enable = false },
    lint = { enable = false },
    scan_cmake_in_package = true, -- default is true
  },
}
