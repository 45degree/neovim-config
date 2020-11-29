local json = require('json.json')

local option_config_list = {}

local function get(name)
    for k,v in ipairs(option_config_list) do
        if v == name then
            return true
        end
    end
    return true
end

local function set(name)
    option_config_list.insert(name)
end

-- general option_config.json
local function write(path)

end

-- read option_config.json
local function read(path)

end

return {
    get = get,
    set = set,
    write = write,
    read = read,
}
