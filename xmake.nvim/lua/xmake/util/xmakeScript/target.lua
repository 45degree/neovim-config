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
    table.insert(names, name)
  end
  print(json.encode(names))
end
