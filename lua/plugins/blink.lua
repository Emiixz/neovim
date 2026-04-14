return {
    "saghen/blink.cmp",
    dependencies = {
        "L3MON4D3/LuaSnip",
    },
    version = "1.*",
    opts = {
        snippets = {
            preset = "luasnip",
        },
        keymap = {
            preset = "none",
            ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
            ["<CR>"] = { "accept", "fallback" },
        },
        completion = {
            menu = {
                auto_show = true,
                border = "rounded",
            },
            documentation = {
                auto_show = false,
                window = { border = "rounded" },
            },
            ghost_text = { enabled = true },
            list = {
                selection = {
                    preselect = true,
                    auto_insert = false,
                },
            },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
    },
}
