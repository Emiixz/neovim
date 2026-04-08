return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load()
		local ls = require("luasnip")
		ls.filetype_extend("javascript", { "jsdoc" })
		ls.filetype_extend("typescript", { "javascript", "jsdoc" })
		ls.filetype_extend("javascriptreact", { "javascript", "jsdoc" })
		ls.filetype_extend("typescriptreact", { "typescript", "javascript", "jsdoc" })
		ls.filetype_extend("php", { "html" })
		ls.filetype_extend("lua", { "luadoc" })
	end,
}
