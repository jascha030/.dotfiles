---@type LazyPluginSpec
return {
    'NickvanDyke/opencode.nvim',
    dependencies = { { 'folke/snacks.nvim' } },
    config = function()
        ---@type opencode.Opts
        vim.g.opencode_opts = {
        }

        vim.o.autoread = true
    end,
    keys = {
        { "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, mode = { "n", "x" }, desc = "Ask opencode" },
        { "<leader>os", function() require("opencode").select() end, mode = { "n", "x" }, desc = "Select opencode action" },
        { "<leader>oo", function() require("opencode").toggle() end, mode = { "n", "t" }, desc = "Toggle opencode" },
        { "go", function() return require("opencode").operator("@this ") end, mode = { "n", "x" }, desc = "Add range to opencode", expr = true },
        { "goo", function() return require("opencode").operator("@this ") .. "_" end, desc = "Add line to opencode", expr = true },
    }
}
