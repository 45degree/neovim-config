command -nargs=? XMakeBuild lua require("xmake_nvim"):Build("<args>")
command -nargs=? XMakeDebug lua require("xmake_nvim"):Debug("<args>")
