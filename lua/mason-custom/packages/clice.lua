---@type RegistryPackageSpec
return {
  schema = 'registry+v1',
  name = 'clice',
  description = [[
A next-generation C++ language server written from scratch on LLVM/Clang, with template intelligence, compilation context, and C++20 named modules support.
]],
  homepage = 'https://github.com/clice-io/clice',
  licenses = { 'Apache-2.0' },
  languages = { 'C', 'C++' },
  categories = { 'LSP' },

  source = {
    id = 'pkg:github/clice-io/clice@v0.1.2026083113',
    asset = {
      {
        target = 'linux_x64_gnu',
        file = 'clice-{{version | strip_prefix "v"}}.x86_64-unknown-linux-gnu.tar.gz',
        bin = 'clice/bin/clice',
      },
      {
        target = 'linux_arm64_gnu',
        file = 'clice-{{version | strip_prefix "v"}}.aarch64-unknown-linux-gnu.tar.gz',
        bin = 'clice/bin/clice',
      },
      {
        target = 'darwin_arm64',
        file = 'clice-{{version | strip_prefix "v"}}.aarch64-apple-darwin.tar.gz',
        bin = 'clice/bin/clice',
      },
      {
        target = 'darwin_x64',
        file = 'clice-{{version | strip_prefix "v"}}.x86_64-apple-darwin.tar.gz',
        bin = 'clice/bin/clice',
      },
      {
        target = 'win_x64',
        file = 'clice-{{version | strip_prefix "v"}}.x86_64-pc-windows-msvc.zip',
        bin = 'clice/bin/clice.exe',
      },
      {
        target = 'win_arm64',
        file = 'clice-{{version | strip_prefix "v"}}.aarch64-pc-windows-msvc.zip',
        bin = 'clice/bin/clice.exe',
      },
    },
  },

  bin = {
    clice = '{{source.asset.bin}}',
  },
}
