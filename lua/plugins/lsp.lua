return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        "saghen/blink.cmp",
    },
    config = function()
        require("fidget").setup({
            notification = {
                window = { winblend = 0 },
            },
        })

        require("mason").setup({
            ui = { border = "rounded" },
        })

        local capabilities = require("blink.cmp").get_lsp_capabilities()

        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "basedpyright", -- ou pyright
                "html",
                "cssls",
                "tailwindcss",
                "intelephense",
                "ts_ls",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,

                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "LuaJIT" },
                                diagnostics = { globals = { "vim" } },
                                workspace = {
                                    library = vim.api.nvim_get_runtime_file("", true),
                                    checkThirdParty = false,
                                },
                                telemetry = { enable = false },
                                completion = { callSnippet = "Replace" },
                                hint = { enable = true },
                            },
                        },
                    })
                end,

                ["basedpyright"] = function()
                    require("lspconfig").basedpyright.setup({
                        capabilities = capabilities,
                        settings = {
                            basedpyright = {
                                analysis = {
                                    typeCheckingMode = "basic",
                                    autoImportCompletions = true,
                                },
                            },
                        },
                    })
                end,

                ["ts_ls"] = function()
                    require("lspconfig").ts_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            typescript = {
                                suggest = { completeFunctionCalls = true },
                                inlayHints = {
                                    includeInlayParameterNameHints = "all",
                                    includeInlayFunctionParameterTypeHints = true,
                                    includeInlayVariableTypeHints = true,
                                    includeInlayPropertyDeclarationTypeHints = true,
                                    includeInlayFunctionLikeReturnTypeHints = true,
                                },
                            },
                            javascript = {
                                suggest = { completeFunctionCalls = true },
                                inlayHints = {
                                    includeInlayParameterNameHints = "all",
                                    includeInlayFunctionParameterTypeHints = true,
                                    includeInlayVariableTypeHints = true,
                                    includeInlayPropertyDeclarationTypeHints = true,
                                    includeInlayFunctionLikeReturnTypeHints = true,
                                },
                            },
                        },
                    })
                end,

                ["tailwindcss"] = function()
                    require("lspconfig").tailwindcss.setup({
                        capabilities = capabilities,
                        filetypes = {
                            "html",
                            "css",
                            "scss",
                            "javascript",
                            "javascriptreact",
                            "typescript",
                            "typescriptreact",
                            "vue",
                            "svelte",
                            "astro",
                        },
                        settings = {
                            tailwindCSS = {
                                experimental = {
                                    classRegex = {
                                        { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                                        { "cx\\(([^)]*)\\)",  "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                                    },
                                },
                            },
                        },
                    })
                end,

                ["intelephense"] = function()
                    require("lspconfig").intelephense.setup({
                        capabilities = capabilities,
                        settings = {
                            intelephense = {
                                files = { maxSize = 1000000 },
                                format = { enable = true },
                            },
                        },
                    })
                end,
            },
        })
    end,
}
