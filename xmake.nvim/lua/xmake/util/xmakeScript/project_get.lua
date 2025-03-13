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

function main(attribute, ...)
  -- load config
  config.load()
  if not os.isfile(os.projectfile()) then return end

  local project_attribute = project[attribute]
  if type(project_attribute) == 'function' then project_attribute = project_attribute(...) end
  print(json.encode(convert_to_valid_json_format(project_attribute)))
end
