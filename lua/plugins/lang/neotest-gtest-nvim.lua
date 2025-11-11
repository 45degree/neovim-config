local c_cxx_file_extensions = {
  ['cpp'] = true,
  ['cppm'] = true,
  ['cc'] = true,
  ['cxx'] = true,
  ['c++'] = true,
}

return {
  {
    'alfaix/neotest-gtest',
    lazy = true,
    opts = {
      ---@param file_path string
      is_test_file = function(file_path)
        local sep = '/'
        if vim.fn.has('win32') == 1 then sep = '\\' end

        local elems = vim.split(file_path, sep, { plain = true })
        local filename = elems[#elems]:lower()
        if filename == '' then -- directory
          return false
        end
        local extsplit = vim.split(filename, '.', { plain = true })
        local extension = extsplit[#extsplit]
        if not c_cxx_file_extensions[extension] then return false end
        local stem = extsplit[#extsplit - 1]
        return vim.startswith(filename, 'test') or vim.endswith(stem, 'test')
      end,
    },
  },

  {
    'nvim-neotest/neotest',
    dependencies = 'alfaix/neotest-gtest',
    opts = function(_, opts)
      opts = opts or {}
      opts.adapters = opts.adapters or {}
      opts.adapters = vim.tbl_deep_extend('force', opts.adapters, { require('neotest-gtest') })
    end,
  },
}
