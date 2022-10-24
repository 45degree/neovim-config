local json = require('json.json')
local io = require('io')

local option_config_list = {}

local function readFile(fileName)
    local f = assert(io.open(fileName,'r'))
    local content = f:read('*all')
    f:close()
    return content
end

local function getLanguage(name)
    return option_config_list['extra_language'][name]
end

local function getColorTheme()
  return option_config_list['colortheme']
end

-- read option_config.json
local function read(path)
    local content = readFile(path)
    option_config_list=json.decode(content)
end

return {
  getLanguage = getLanguage,
  getColorTheme = getColorTheme,
  read = read,
}
