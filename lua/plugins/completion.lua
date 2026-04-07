return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local ls = require("luasnip")

		ls.config.set_config({
			history = true,
			updateevents = "TextChanged,TextChangedI",
			enable_autosnippets = true,
			ext_opts = {
				[require("luasnip.util.types").choiceNode] = {
					active = {
						virt_text = { { "●", "DiagnosticHint" } },
					},
				},
			},
		})

		require("luasnip.loaders.from_vscode").lazy_load()

		ls.filetype_extend("javascript", { "jsdoc" })
		ls.filetype_extend("typescript", { "javascript", "jsdoc" })
		ls.filetype_extend("javascriptreact", { "javascript", "jsdoc" })
		ls.filetype_extend("typescriptreact", { "typescript", "javascript", "jsdoc" })
		ls.filetype_extend("php", { "html" })
		ls.filetype_extend("lua", { "luadoc" })

		vim.keymap.set({ "i", "s" }, "<C-l>", function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			end
		end, { silent = true, desc = "Expandir/Próximo campo" })

		vim.keymap.set({ "i", "s" }, "<C-h>", function()
			if ls.jumpable(-1) then
				ls.jump(-1)
			end
		end, { silent = true, desc = "Campo anterior" })

		vim.keymap.set({ "i", "s" }, "<C-e>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, { silent = true, desc = "Próxima opção" })
	end,
}
