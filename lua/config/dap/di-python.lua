local dap_install = require("dap-install")
dap_install.config(
	"python",
  {
    configurations = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          local h = {}
          if vim.fn.has('win32') == 1 then
            h = io.open("where python")
            vim.notify("can't find python in windows", "error")
            return ""
          else
            h = io.popen('command -v python')
            if h == nil then
              return "/usr/bin/python"
            end
          end

          local lines = h:lines();
          return lines()
        end
      },
    }
  }
)
