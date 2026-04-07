return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {
          {
            'filename',
            path = 1,  -- 0 = apenas nome, 1 = caminho relativo, 2 = absoluto, 3 = absoluto com ~, 4 = nome + dir pai
            shorting_target = 40,  -- Encurta o caminho para deixar 40 espaços para outros componentes
            file_status = true,  -- Mostra status (readonly, modificado)
            newfile_status = false,  -- Mostra status de arquivo novo
            symbols = {
              modified = '[+]',
              readonly = '[-]',
              unnamed = '[No Name]',
              newfile = '[New]',
            }
          }
        },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            'filename',
            path = 1,  -- Caminho relativo também para janelas inativas
          }
        },
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  end,
}
