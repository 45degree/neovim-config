local JSON = require('json.json')
local os = require('os')
local XMake = {
}

function XMake:Build(targetName)
    print('begin to build '..targetName)
    local cmd = io.popen('xmake build '..targetName)
    for line in cmd:lines() do
        print(line)
    end
    print('build '..targetName..'finished')
end

function XMake:Debug(targetName)
    print(targetName)
end

return XMake;
