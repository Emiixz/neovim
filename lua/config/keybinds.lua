vim.g.mapleader = " "

vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

vim.keymap.set("n", "<leader>ya", ":%y+<CR>", { desc = "Copiar arquivo inteiro para clipboard do sistema" })
