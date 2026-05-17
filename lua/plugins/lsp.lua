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

        local lspconfig = require("lspconfig")
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        local function setup(server, opts)
            lspconfig[server].setup(vim.tbl_extend("force", { capabilities = capabilities }, opts or {}))
        end

        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "pyright",
                "html",
                "cssls",
                "tailwindcss",
                "intelephense",
                "vtsls",
                "emmet_language_server",
            },
            handlers = {
                function(server_name)
                    setup(server_name)
                end,

                ["lua_ls"] = function()
                    setup("lua_ls", {
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

                ["pyright"] = function()
                    setup("pyright", {
                        settings = {
                            python = {
                                analysis = {
                                    typeCheckingMode = "basic",
                                    autoImportCompletions = true,
                                    autoSearchPaths = true,
                                    useLibraryCodeForTypes = true,
                                },
                            },
                        },
                    })
                end,

                ["html"] = function()
                    setup("html", {
                        filetypes = { "html", "templ" },
                        init_options = {
                            provideFormatter = true,
                            embeddedLanguages = { css = true, javascript = true },
                            configurationSection = { "html", "css", "javascript" },
                        },
                    })
                end,

                ["cssls"] = function()
                    setup("cssls", {
                        settings = {
                            css  = { validate = true, lint = { unknownAtRules = "ignore" } },
                            scss = { validate = true, lint = { unknownAtRules = "ignore" } },
                            less = { validate = true, lint = { unknownAtRules = "ignore" } },
                        },
                    })
                end,

                ["vtsls"] = function()
                    setup("vtsls", {
                        filetypes = {
                            "javascript", "javascriptreact",
                            "typescript", "typescriptreact",
                            "html",
                        },
                        settings = {
                            typescript = {
                                suggest = { completeFunctionCalls = true },
                                inlayHints = {
                                    parameterNames = { enabled = "all" },
                                    functionLikeReturnTypes = { enabled = true },
                                    variableTypes = { enabled = true },
                                },
                            },
                            javascript = {
                                suggest = { completeFunctionCalls = true },
                                inlayHints = {
                                    parameterNames = { enabled = "all" },
                                    functionLikeReturnTypes = { enabled = true },
                                    variableTypes = { enabled = true },
                                },
                            },
                        },
                    })
                end,

                ["tailwindcss"] = function()
                    setup("tailwindcss", {
                        filetypes = {
                            "html", "css", "scss",
                            "javascript", "javascriptreact",
                            "typescript", "typescriptreact",
                            "vue", "svelte", "astro",
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

                ["emmet_language_server"] = function()
                    setup("emmet_language_server", {
                        filetypes = { "html", "css", "scss", "sass", "javascriptreact", "typescriptreact" },
                    })
                end,

                ["intelephense"] = function()
                    setup("intelephense", {
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
