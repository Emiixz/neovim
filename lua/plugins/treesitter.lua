return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" }, -- carrega só quando abre arquivo
    config = function()
        require("nvim-treesitter").setup({
            ensure_installed = {
                -- base
                "lua", "vim", "vimdoc", "query",
                -- web
                "html", "css", "javascript", "typescript", "tsx",
                -- backend (ajuste para o que você usa)
                "python", "go", "rust",
                -- dados/config
                "json", "yaml", "toml", "markdown", "markdown_inline",
                -- git
                "diff", "gitcommit", "gitignore",
            },
            auto_install = true, -- instala parser automaticamente ao abrir arquivo
        })

        -- highlight via treesitter
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                -- só ativa se o parser existir para esse filetype
                local ok, _ = pcall(vim.treesitter.start, args.buf)
                if not ok then
                    -- fallback para o highlight padrão do vim
                    vim.bo[args.buf].syntax = "on"
                end
            end,
        })

        -- folding desativado (mantido como você quer)
        vim.opt.foldmethod = "manual"
        vim.opt.foldenable = false
    end,
}
