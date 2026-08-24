---@meta

---@class jascha030.PathEntryTable
---@field path string
---@field prepend? boolean

---@alias jascha030.PathEntry string|jascha030.PathEntryTable

---@class jascha030.PathConfig
---@field env? jascha030.PathEntry[]
---@field rtp? jascha030.PathEntry[]

---@class jascha030.Config
---@field debug? boolean
---@field path? jascha030.PathConfig
---@field colorscheme? string

---@alias jascha030.PathType 'env'|'rtp'

---@class jascha030.lsp.MapOpts
---@field mode? string|string[]
---@field has? string
---@field expr? boolean
---@field desc? string

---@alias jascha030.lsp.DiagnosticSeverityString 'ERROR'|'WARN'|'HINT'|'INFO'

---@alias jascha030.lsp.AttachCallback fun(client: vim.lsp.Client, buffer: integer)

---@alias jascha030.utils.ThemeMode 'dark'|'light'

---@class jascha030.zsh_symbols.Symbol
---@field name string
---@field kind jascha030.zsh_symbols.SymbolKind
---@field path string
---@field line integer?
---@field character integer?
---@field container_name string

---@alias jascha030.zsh_symbols.SymbolKind 'explicit'|'autoload'

---@class jascha030.zsh_symbols.Index
---@field all jascha030.zsh_symbols.Symbol[]
---@field by_name table<string, jascha030.zsh_symbols.Symbol[]>
---@field by_file table<string, jascha030.zsh_symbols.Symbol[]>

---@class jascha030.icons.IconMap
---@field alias? string
---@field asterisk? string
---@field bookmark? string
---@field brush? string
---@field calendar? string
---@field composer? string
---@field computer? string
---@field database? string
---@field documentation? string
---@field editor? string
---@field fileinfo? string
---@field finder? string
---@field git? string
---@field git_sync? string
---@field git_branch? string
---@field git_merge? string
---@field git_reject? string
---@field ignore? string
---@field init? string
---@field key? string
---@field list? string
---@field loadspeaker? string
---@field mac? string
---@field mute? string
---@field npm? string
---@field nmode? string
---@field pin? string
---@field rocket? string
---@field scholar? string
---@field picker? string
---@field term? string
---@field wrench? string
---@field lockfile? string
---@field bitbucket? string
---@field ['package']? string
---@field cmp_icons? table<string, string>
---@field diagnostics? table<integer, string>
