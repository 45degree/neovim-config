---@diagnostic disable: undefined-field, undefined-global

-- imports
import('core.project.config')
import('core.project.project')
import('core.base.json')

-- recursively target add env
local function _add_target_pkgenvs(target, targets_added)
  if targets_added[target:name()] then return end
  targets_added[target:name()] = true
  os.addenvs(target:pkgenvs())
  for _, dep in ipairs(target:orderdeps()) do
    _add_target_pkgenvs(dep, targets_added)
  end
end

function main(targetname)
  -- load config
  config.load()
  if not os.isfile(os.projectfile()) then return end

  -- get target
  local target = nil
  if targetname then target = project.target(targetname) end
  if not target then
    for _, t in pairs(project.targets()) do
      local default = t:get('default')
      if (default == nil or default == true) and t:get('kind') == 'binary' then
        target = t
        break
      end
    end
  end

  _add_target_pkgenvs(target, {})
  local envs = os.getenvs()
  print(json.encode(envs))
end
