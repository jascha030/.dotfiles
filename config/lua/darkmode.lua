local shell = require('shell')
local M = {}

M.cmd = [[echo $(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo 'dark' || echo 'light')]]

function M.enabled()
    return (shell.shell_exec(M.cmd)):find('dark') ~= nil
end

return M
