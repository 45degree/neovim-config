local overseer = require('overseer')

local function find_pixi_toml() return vim.fs.find('pixi.toml', { type = 'file', upward = true })[1] end

---@type overseer.TemplateFileProvider
local provider = {
  cache_key = find_pixi_toml,
  condition = {
    callback = function(opts)
      if vim.fn.executable('pixi') == 0 then return false, 'Command "pixi" not found' end
      if not find_pixi_toml() then return false, 'No pixi.toml found' end
      return true
    end,
  },

  -- Lists every pixi task as an overseer template by parsing `pixi task list --json`.
  -- Structure: [{ environment, features: [{ name, tasks: [{ name, cmd, description, ... }] }] }]
  generator = function(opts, cb)
    local cwd = vim.fs.dirname(find_pixi_toml())

    overseer.builtin.system(
      { 'pixi', 'task', 'list', '--json' },
      { cwd = cwd, text = true },
      vim.schedule_wrap(function(out)
        if out.code ~= 0 then return cb(out.stderr or out.stdout or 'pixi task list failed') end

        local ok, data = pcall(vim.json.decode, out.stdout, { luanil = { object = true, array = true } })
        if not ok then return cb('Failed to parse pixi task list JSON') end

        local ret = {}
        local seen = {}
        for _, env in ipairs(data) do
          for _, feature in ipairs(env.features or {}) do
            for _, task in ipairs(feature.tasks or {}) do
              local name = task.name
              -- Skip hidden tasks (prefixed with "_") and dedupe across environments/features.
              -- pixi resolves cwd/env/depends_on internally, so we only pin the project root.
              if name and name:sub(1, 1) ~= '_' and not seen[name] then
                seen[name] = true
                ---@type overseer.TemplateFileDefinition
                local tmpl = {
                  name = 'pixi: ' .. name,
                  builder = function() return { cmd = 'pixi', args = { 'run', name }, cwd = cwd } end,
                  desc = task.description,
                }
                table.insert(ret, tmpl)
              end
            end
          end
        end

        cb(ret)
      end)
    )
  end,
}

return provider
