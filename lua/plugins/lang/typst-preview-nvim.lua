return {
  'chomosuke/typst-preview.nvim',
  ft = 'typst',
  enabled = require('config').lang.typst,
  dependence = 'williamboman/mason.nvim',
  build = function() require('typst-preview').update() end,
  config = function()
    local dependencies_bin = {
      ['typst-preview'] = nil,
      ['websocat'] = nil,
    }
    if require('util.mason').is_mason_package_installed('tinymist') then dependencies_bin['typst-preview'] = vim.fn.exepath('tinymist') end

    require('typst-preview').setup({
      dependencies_bin = dependencies_bin,
      -- This function will be called to determine the root of the typst project
      get_root = function(path_of_main_file)
        local root = vim.fs.root(path_of_main_file, '.git')
        if root then return root end
        return vim.fn.fnamemodify(path_of_main_file, ':p:h')
      end,

      -- This function will be called to determine the main file of the typst
      -- project.
      get_main_file = function(path_of_buffer)
        local root = vim.fs.root(0, '.git')
        if root then
          local main_file = vim.fs.find('main.typ', { type = 'file', path = root })
          if main_file then return main_file[1] end
        end
        return path_of_buffer
      end,
    })
  end,
}
