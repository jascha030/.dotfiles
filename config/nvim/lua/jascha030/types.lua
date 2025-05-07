---@alias jascha030.core.config.PathConfigOption string[]|table{path: string, prepend: boolean}
---@alias jascha030.core.config.PathConfigOptionType "env"|"rtp"

---@class jascha030.core.config.ConfigOptions
---@field colorscheme boolean|string 
---@field debug boolean 
---@field keymaps jascha030.core.config.KeymapConfigOptions
---@field opts jascha030.core.config.VimConfigOptions
---@field path jascha030.core.config.PathConfigOptions
---@field polyglot table
---@field augroups table

---@class jascha030.core.config.PathConfigOptions
---@field env? jascha030.core.config.PathConfigOption[]
---@field rtp? jascha030.core.config.PathConfigOption[]

---@class jascha030.core.config.VimConfigOptions
---@field g? table
---@field o? table
---@field opt? table

---@class jascha030.core.config.KeymapConfigOptions
---@field i? table
---@field n? table
---@field t? table
---@field v? table

---@class jascha030.core.config
---@field options jascha030.core.config.ConfigOptions
---@diagnostic disable-next-line: missing-fields

---@alias jascha030.core.options.Scope "g"|"o"|"b"|"bo"|"w"|"wo"|"opt"
