return {
	"github/copilot.vim",
	event = "InsertEnter",
	config = function()
		vim.g.copilot_no_tab_map = true

		vim.g.copilot_filetypes = {
			["*"] = true,
			["TelescopePrompt"] = false,
			["neo-tree"] = false,
			["lazy"] = false,
			["mason"] = false,
		}

		vim.keymap.set("i", "<C-j>", 'copilot#Accept("\\<CR>")', {
			expr = true,
			replace_keycodes = false,
			silent = true,
			desc = "Aceitar Copilot",
		})

		vim.keymap.set("i", "<M-l>", "<Plug>(copilot-next)", {
			silent = true,
			desc = "Próxima sugestão Copilot",
		})

		vim.keymap.set("i", "<M-h>", "<Plug>(copilot-previous)", {
			silent = true,
			desc = "Sugestão anterior Copilot",
		})

		vim.keymap.set("i", "<C-x>", "<Plug>(copilot-dismiss)", {
			silent = true,
			desc = "Descartar Copilot",
		})

		vim.keymap.set("n", "<leader>tc", function()
			if vim.g.copilot_enabled == false then
				vim.cmd("Copilot enable")
				vim.notify("Copilot enabled", vim.log.levels.INFO)
			else
				vim.cmd("Copilot disable")
				vim.notify("Copilot disabled", vim.log.levels.WARN)
			end
		end, { desc = "Toggle Copilot" })
	end,
}
