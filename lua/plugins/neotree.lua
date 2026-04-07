return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,

			popup_border_style = "rounded",

			filesystem = {
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},

			window = {
				width = 32,
				mappings = {
					["<space>"] = "toggle_node",
					["<cr>"] = "open",
					["S"] = "open_split",
					["s"] = "open_vsplit",
				},
			},
		})

		-- Keymaps
		vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>", { silent = true })
		vim.keymap.set("n", "<leader>e", ":Neotree focus<CR>", { silent = true })
	end,
}
