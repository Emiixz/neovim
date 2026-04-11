return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				section_separators = "",
				component_separators = "",
				globalstatus = true,
			},

			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },

				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},

				lualine_x = {
					"diagnostics",
					"filetype",
				},

				lualine_y = { "progress" },
				lualine_z = { "location" },
			},

			inactive_sections = {
				lualine_c = { "filename" },
				lualine_x = { "location" },
			},
		})
	end,
}
