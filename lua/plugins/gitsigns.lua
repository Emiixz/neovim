return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        signs = {
            add          = { text = "│" },
            change       = { text = "│" },
            delete       = { text = "_" },
            topdelete    = { text = "‾" },
            changedelete = { text = "~" },
            untracked    = { text = "┆" },
        },
        -- blame inline (mostra autor da linha em cinza)
        current_line_blame = true,
        current_line_blame_opts = {
            delay = 500, -- aparece após 500ms parado na linha
        },
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            local map = function(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
            end

            -- navegação entre hunks
            map("n", "]c", gs.next_hunk, "Next hunk")
            map("n", "[c", gs.prev_hunk, "Prev hunk")

            -- ações
            map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
            map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
            map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
            map("n", "<leader>hb", gs.blame_line, "Blame line")
            map("n", "<leader>hd", gs.diffthis, "Diff this")

            -- toggle blame inline
            map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle blame")
        end,
    },
}
