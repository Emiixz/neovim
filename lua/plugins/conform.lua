return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	config = function()
		require("conform").setup({
			format_on_save = function(bufnr)
				-- Desabilita se usuário desabilitou
				if vim.g.disable_autoformat then
					return
				end

				-- Desabilita em arquivos grandes
				if vim.api.nvim_buf_line_count(bufnr) > 10000 then
					return
				end

				return {
					timeout_ms = 3000, -- Reduzido para não travar
					lsp_format = "fallback",
					quiet = false,
				}
			end,

			formatters_by_ft = {
				-- Compiladas
				c = { "clang-format" },
				cpp = { "clang-format" },
				rust = { "rustfmt" },
				go = { "gofmt" },
				zig = { "zigfmt" },

				-- Scripting
				lua = { "stylua" },
				python = { "isort", "black" },

				-- Web
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				astro = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },

				-- Outros
				php = { "pint", "php_cs_fixer" },
				sh = { "shfmt" },
			},

			formatters = {
				["clang-format"] = {
					prepend_args = { "-style=file", "-fallback-style=LLVM" },
				},
				prettier = {
					prepend_args = { "--prose-wrap", "always" },
				},
			},
		})

		-- Format manual
		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			require("conform").format({
				async = true,
				lsp_format = "fallback",
			})
		end, { desc = "Formatar buffer/seleção" })

		-- Toggle autoformat
		vim.keymap.set("n", "<leader>tf", function()
			vim.g.disable_autoformat = not vim.g.disable_autoformat
			local status = vim.g.disable_autoformat and "desabilitado" or "habilitado"
			vim.notify("Autoformat " .. status, vim.log.levels.INFO)
		end, { desc = "Toggle autoformat" })
	end,
}
