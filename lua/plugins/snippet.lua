return {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local ls = require("luasnip")

        ls.setup({
            history = true,
            updateevents = "TextChanged,TextChangedI",
            delete_check_events = "TextChanged",
            enable_autosnippets = false,
        })

        require("luasnip.loaders.from_vscode").lazy_load()

        ls.filetype_extend("javascript", { "jsdoc" })
        ls.filetype_extend("typescript", { "javascript", "jsdoc" })
        ls.filetype_extend("javascriptreact", { "javascript", "jsdoc" })
        ls.filetype_extend("typescriptreact", { "typescript", "javascript", "jsdoc" })
        ls.filetype_extend("php", { "html", "css" })
        ls.filetype_extend("lua", { "luadoc" })
    end,
}
