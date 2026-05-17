return {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,    -- carrega na inicialização
    priority = 1000, -- garante que carrega antes de outros plugins
    config = function()
        require("rose-pine").setup({
            variant = "moon", -- força o tema moon
            dark_variant = "moon",
            styles = {
                bold = true,
                italic = true,
                transparency = true,
            },
        })
        vim.cmd("colorscheme rose-pine-moon")
    end,
}
