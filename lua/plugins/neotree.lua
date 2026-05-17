return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    -- keymaps aqui no lazy, não dentro do config
    keys = {
        { "<C-n>",      "<cmd>Neotree toggle<cr>",     desc = "Toggle file tree" },
        { "<leader>e",  "<cmd>Neotree focus<cr>",      desc = "Focus file tree" },
        { "<leader>ge", "<cmd>Neotree git_status<cr>", desc = "Git status tree" },
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            popup_border_style = "rounded",

            -- fecha ao abrir um arquivo
            event_handlers = {
                {
                    event = "file_opened",
                    handler = function()
                        require("neo-tree.command").execute({ action = "close" })
                    end,
                },
            },

            default_component_configs = {
                indent = {
                    indent_size = 2,
                    with_markers = true,
                    indent_marker = "│",
                    last_indent_marker = "└",
                },
                git_status = {
                    symbols = {
                        added     = "✚",
                        modified  = "",
                        deleted   = "✖",
                        renamed   = "󰁕",
                        untracked = "",
                        ignored   = "",
                        unstaged  = "󰄱",
                        staged    = "",
                        conflict  = "",
                    },
                },
            },

            filesystem = {
                follow_current_file = { enabled = true },
                use_libuv_file_watcher = true, -- atualiza sem precisar de :e
                filtered_items = {
                    visible = false,           -- itens filtrados ficam ocultos
                    hide_dotfiles = false,     -- mostra .env, .gitignore etc
                    hide_gitignored = true,    -- oculta o que está no .gitignore
                },
            },

            window = {
                width = 32,
                mappings = {
                    ["<space>"] = "toggle_node",
                    ["<cr>"]    = "open",
                    ["S"]       = "open_split",
                    ["s"]       = "open_vsplit",
                    ["h"]       = "close_node",    -- fecha pasta com h
                    ["l"]       = "open",          -- abre com l (estilo vim)
                    ["H"]       = "toggle_hidden", -- alterna arquivos ocultos
                },
            },
        })
    end,
}
