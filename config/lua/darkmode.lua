local shell = require('shell')
local M = {}

M.cmd = [[echo $(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo 'dark' || echo 'light')]]

function M.enabled()
    shell.shell_exec(M.cmd)
end

return M
