function OSDarkmodeEnabled()
    local cmd = [[echo $(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo 'dark' || echo 'light')]]

    return (vim.call('system', cmd)):find('dark') ~= nil
end

function DarkmodeEnabled()
    return vim.o.background == 'dark'
end

