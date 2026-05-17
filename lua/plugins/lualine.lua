return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status")

        local mode = {
            "mode",
            fmt = function(str)
                return " " .. str
            end,
        }

        local diff = {
            "diff",
            colored = true,
            symbols = { added = " ", modified = " ", removed = " " },
        }

        local filename = {
            "filename",
            file_status = true,
            path = 1,             -- path relativo
            shorting_target = 40, -- encurta quando a janela for pequena
            symbols = {
                modified = " ●",
                readonly = " ",
                unnamed = "[sem nome]",
                newfile = "[novo]",
            },
        }

        local branch = { "branch", icon = "" }

        local diagnostics = {
            "diagnostics",
            sources = { "nvim_lsp" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
            colored = true,
            update_in_insert = false, -- não pisca enquanto digita
        }

        local filetype = {
            "filetype",
            icon_only = false,
            colored = true,
        }

        lualine.setup({
            options = {
                icons_enabled = true, -- ← aqui dentro de options
                theme = "auto",
                component_separators = { left = "│", right = "│" }, -- │ fica mais limpo que |
                section_separators = { left = "", right = "" }, -- simétricas
                globalstatus = true, -- uma statusline global (requer nvim 0.7+)
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = { mode },
                lualine_b = { branch, diagnostics },
                lualine_c = { diff, filename },
                lualine_x = {
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = "#ff9e64" }, -- laranja para chamar atenção
                    },
                    filetype,
                },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_c = { filename },
                lualine_x = { "location" },
            },
        })
    end,
}
