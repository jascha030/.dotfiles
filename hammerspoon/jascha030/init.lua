return setmetatable({}, {
    __index = function(_, key)
        local ok, submodule = pcall(require, 'jascha030.' .. key)

        if not ok then
            error('Unknown module "' .. key .. '"')
        end

        return submodule
    end,
})
