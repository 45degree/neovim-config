---@diagnostic disable: undefined-global, undefined-field
import('core.project.config')
import('core.project.project')
import('core.base.json')

local function convert_to_valid_json_format(objs)
  local obj_type = type(objs)
  if obj_type == 'string' or obj_type == 'number' or obj_type == 'boolean' then
    return objs
  elseif obj_type == 'table' then
    local result = {}
    for k, v in pairs(objs) do
      result[k] = convert_to_valid_json_format(v)
    end
    return result
  end
end

function main(target_name, attribute, ...)
  -- load config
  config.load()
  if not os.isfile(os.projectfile()) then return end

  -- get target
  local target = nil
  if target_name then target = project.target(target_name) end
  if not target then
    for _, t in pairs(project.targets()) do
      local default = t:get('default')
      if (default == nil or default == true) and t:get('kind') == 'binary' then
        target = t
        break
      end
    end
  end

  if not target then return end

  local target_attribute = target[attribute]
  if type(target_attribute) == 'function' then target_attribute = target_attribute(target, ...) end
  print(json.encode(convert_to_valid_json_format(target_attribute)))
end
