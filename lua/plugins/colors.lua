return {
	"olimorris/onedarkpro.nvim",
	priority = 1000, -- carrega antes de tudo
	config = function()
		require("onedarkpro").setup({
			options = {
				transparency = false, -- opcional
			},
		})

		vim.cmd("colorscheme onedark_dark")
		--vim.cmd("colorscheme onelight")
	end,
}
