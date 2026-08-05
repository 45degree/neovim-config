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
    id = 'pkg:github/clice-io/clice@v0.1.2026080405',
    asset = {
      {
        target = 'linux_x64_gnu',
        file = 'clice-x64-linux-gnu.tar.gz',
        bin = 'clice/bin/clice',
      },
      {
        target = 'linux_arm64_gnu',
        file = 'clice-arm64-linux-gnu.tar.gz',
        bin = 'clice/bin/clice',
      },
      {
        target = 'darwin_arm64',
        file = 'clice-arm64-macos-darwin.tar.gz',
        bin = 'clice/bin/clice',
      },
      {
        target = 'darwin_x64',
        file = 'clice-x64-macos-darwin.tar.gz',
        bin = 'clice/bin/clice',
      },
      {
        target = 'win_x64',
        file = 'clice-x64-windows-msvc.zip',
        bin = 'clice/bin/clice.exe',
      },
      {
        target = 'win_arm64',
        file = 'clice-arm64-windows-msvc.zip',
        bin = 'clice/bin/clice.exe',
      },
    },
  },

  bin = {
    clice = '{{source.asset.bin}}',
  },
}
