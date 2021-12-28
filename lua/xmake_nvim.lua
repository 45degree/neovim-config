local JSON = require('json.json')
local os = require('os')
local XMake = {
}

function XMake:Build(targetName)
    print('begin to build '..targetName)
    os.execute('xmake build '..targetName)
    print('build '..targetName..'finished')
end

function XMake:Debug(targetName)
    print(targetName)
end

return XMake;
