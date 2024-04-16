---@diagnostic disable: undefined-global, undefined-field
import('core.project.config')
import('core.project.project')

function main(target_name, attribute, ...)
  local is_path = string.find(attribute, 'path') ~= nil or string.find(attribute, 'dir') ~= nil or string.find(attribute, 'file') ~= nil

  -- load config
  config.load()
  if not os.isfile(os.projectfile()) then
    return
  end

  -- get target
  local target = nil
  if target_name then
    target = project.target(target_name)
  end
  if not target then
    for _, t in pairs(project.targets()) do
      local default = t:get('default')
      if (default == nil or default == true) and t:get('kind') == 'binary' then
        target = t
        break
      end
    end
  end

  local function print_attribute(v)
    if is_path and type(v) == 'string' then
      print(path.absolute(v))
    else
      print(v)
    end
  end

  -- get target path
  if target then
    local target_attribute = target[attribute](target, ...)
    if type(target_attribute) ~= 'table' then
      print_attribute(target_attribute)
    else
      for _, v in ipairs(target_attribute) do
        print_attribute(v)
      end
    end
  end

  -- print end tag to ignore other deprecated/warnings infos
  print('__end__')
end
