
return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      local db = require("dashboard")

      local function footer_lines()
        local lines = vim.o.lines
        -- calcula quantas linhas vazias colocar: metade da tela menos 1
        local empty = math.floor(lines / 2) - 1
        local t = {}
        for i = 1, empty do
          table.insert(t, "")
        end
        return t
      end

      db.setup({
        theme = "doom",
        config = {
          header = footer_lines(), -- coloca as linhas calculadas antes do footer
          center = {},
          footer = {
            "An idiot admires complexity, a genius admires simplicity. -- Terry A. Davis",
          },
        },
      })
    end,
  },
}
