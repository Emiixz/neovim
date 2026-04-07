return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects", -- Textobjects úteis
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				-- Essenciais
				"lua", "vim", "vimdoc", "query",
				-- Web
				"javascript", "typescript", "tsx", "html", "css",
				"json", "yaml", "markdown", "markdown_inline",
				-- Backend
				"python", "php", "go", "rust", "c",
				-- Outros
				"bash", "dockerfile", "gitignore", "astro",
			},
			
			auto_install = true,
			
			highlight = {
				enable = true,
				-- Performance: desabilitar em arquivos grandes
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
				additional_vim_regex_highlighting = false,
			},
			
			indent = { 
				enable = true,
				-- Desabilitar para Python (conflita com indent-blankline)
				disable = { "python" },
			},
			
			-- Textobjects para seleção inteligente
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
					},
				},
			},
		})
	end,
}
