return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"j-hui/fidget.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		require("fidget").setup({
			notification = {
				window = { winblend = 0 },
			},
		})

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		require("mason").setup({
			ui = { border = "rounded" },
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"jedi_language_server",
				"rust_analyzer",
				"gopls",
				"tailwindcss",
				"intelephense",
				"ts_ls",
			},
			automatic_installation = true,
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({ capabilities = capabilities })
				end,
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = { version = "LuaJIT" },
								diagnostics = { globals = { "vim" } },
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false,
								},
								telemetry = { enable = false },
								completion = { callSnippet = "Replace" },
								hint = { enable = true },
							},
						},
					})
				end,
				["tailwindcss"] = function()
					require("lspconfig").tailwindcss.setup({
						capabilities = capabilities,
						filetypes = {
							"html",
							"css",
							"scss",
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"vue",
							"svelte",
							"astro",
						},
						settings = {
							tailwindCSS = {
								experimental = {
									classRegex = {
										{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
										{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
									},
								},
							},
						},
					})
				end,
				["intelephense"] = function()
					require("lspconfig").intelephense.setup({
						capabilities = capabilities,
						settings = {
							intelephense = {
								files = { maxSize = 1000000 },
								format = { enable = true },
							},
						},
					})
				end,
				["ts_ls"] = function()
					require("lspconfig").ts_ls.setup({
						capabilities = capabilities,
						settings = {
							typescript = {
								inlayHints = {
									includeInlayParameterNameHints = "all",
									includeInlayFunctionParameterTypeHints = true,
								},
							},
						},
					})
				end,
			},
		})

		vim.diagnostic.config({
			virtual_text = { prefix = "●", source = "if_many" },
			signs = true,
			update_in_insert = false,
			underline = true,
			severity_sort = true,
			float = {
				focusable = true,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local buf = ev.buf
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true, desc = desc })
				end

				map("n", "gd", vim.lsp.buf.definition, "Ir para definição")
				map("n", "gD", vim.lsp.buf.declaration, "Ir para declaração")
				map("n", "gi", vim.lsp.buf.implementation, "Ir para implementação")
				map("n", "gr", vim.lsp.buf.references, "Ver referências")
				map("n", "gt", vim.lsp.buf.type_definition, "Ir para tipo")
				map("n", "K", vim.lsp.buf.hover, "Hover")
				map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
				map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
				map("n", "[d", vim.diagnostic.goto_prev, "Diagnóstico anterior")
				map("n", "]d", vim.diagnostic.goto_next, "Próximo diagnóstico")
				map("n", "<leader>e", vim.diagnostic.open_float, "Ver diagnóstico")
				map("n", "<leader>q", vim.diagnostic.setloclist, "Lista de diagnósticos")

				if vim.lsp.inlay_hint then
					map("n", "<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
					end, "Toggle inlay hints")
				end
			end,
		})
	end,
}
