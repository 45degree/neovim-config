-- imports
import('core.project.config')
import('core.project.project')
import('core.base.json')

-- main entry
function main()
  -- load config
  config.load()

  -- print targets
  local names = {}
  for name, target in pairs((project.targets())) do
    if target:get('kind') == 'binary' then table.insert(names, name) end
  end
  print(json.encode(names))
end
