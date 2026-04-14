require("config.options")
require("config.keybinds")
require("config.lazy")

-- Remove o snippet nativo do Neovim que conflita com blink
vim.schedule(function()
    pcall(vim.keymap.del, "i", "<Tab>")
    pcall(vim.keymap.del, "s", "<Tab>")
end)
