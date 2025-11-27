local function get_compile_commands() return vim.fs.find('compile_commands.json', { type = 'file' })[1] end

local function get_run_clang_tidy_file()
  local paths = vim.split(vim.env.PATH, vim.fn.has('WIN32') and ';' or ':')
  local run_clang_tidy_files = { 'run-clang-tidy', 'run-clang-tidy.py' }
  for _, path in ipairs(paths) do
    for _, file in ipairs(run_clang_tidy_files) do
      if vim.fn.filereadable(path .. '/' .. file) == 1 then return path .. '/' .. file end
    end
  end
  return nil
end

---@type overseer.TemplateFileProvider
local provider = {
  cache_key = get_compile_commands,
  condition = {
    callback = function(opts)
      if vim.fn.executable('clang-tidy') == 0 then return false, 'Command "clang-tidy" not found' end
      if not get_compile_commands() then return false, 'No compile_commands found' end
      return true
    end,
  },

  generator = function(opts, cb)
    local cwd = vim.fs.dirname(get_compile_commands())
    local file = vim.api.nvim_buf_get_name(0)

    ---@type overseer.TemplateFileDefinition
    local clang_tidy_single_file = {
      name = 'clang-tidy',
      builder = function()
        local args = { file, '-quiet', '-p', cwd }
        if vim.fn.filereadable(cwd .. '/.clang-tidy') == 1 then
          table.insert(args, '-config-file')
          table.insert(args, cwd .. '/.clang-tidy')
        end

        return {
          cmd = 'clang-tidy',
          args = args,
          components = { { 'on_output_quickfix', set_diagnostics = true }, 'on_result_diagnostics', 'default' },
          cwd = cwd,
        }
      end,
      desc = 'Run clang-tidy on the single file',
      tags = { 'LINT' },
      condition = { filetype = { 'c', 'cpp' } },
    }

    ---@type overseer.TemplateFileDefinition
    local clang_tidy_project = {
      name = 'clang-tidy',
      builder = function()
        local args = { '-quiet', '-p', cwd }
        if vim.fn.filereadable(cwd .. '/.clang-tidy') == 1 then
          table.insert(args, '-config-file')
          table.insert(args, cwd .. '/.clang-tidy')
        end

        if vim.fn.executable('run-clang-tidy') == 1 then
          return {
            cmd = 'run-clang-tidy',
            args = args,
            components = { { 'on_output_quickfix', set_diagnostics = true }, 'on_result_diagnostics', 'default' },
            cwd = cwd,
          }
        end

        local run_clang_tidy_path = get_run_clang_tidy_file()
        table.insert(args, 1, run_clang_tidy_path)

        return {
          cmd = 'python',
          args = args,
          components = { { 'on_output_quickfix', set_diagnostics = true }, 'on_result_diagnostics', 'default' },
          cwd = cwd,
        }
      end,
      desc = 'Run clang-tidy on the project',
      tags = { 'LINT' },
      condition = { filetype = { 'c', 'cpp' } },
    }

    return { clang_tidy_single_file, clang_tidy_project }
  end,
}

return provider
