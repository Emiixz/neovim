return {
    "Kopihue/after-dark",
    lazy = false,    -- carrega no startup (recomendado pra tema)
    priority = 1000, -- garante que o tema vem primeiro
    config = function()
        vim.o.background = "dark"
        vim.cmd.colorscheme("after-dark")
    end,
}
