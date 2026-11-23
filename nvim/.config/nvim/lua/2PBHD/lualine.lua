local rose_pine = require("lualine.themes.rose-pine")

rose_pine.normal.c.bg = "none"
rose_pine.insert.c.bg = "none"
rose_pine.visual.c.bg = "none"
rose_pine.replace.c.bg = "none"
rose_pine.command.c.bg = "none"
rose_pine.inactive.c.bg = "none"

require("lualine").setup({
    options = {
        theme = rose_pine,
        section_separators = "",
        component_separators = "",
        globalstatus = true,
        always_show_tabline = true
    },
    sections = {
        lualine_a = {
            {
                "mode",
                color = { fg = "", bg = "none" },
                padding = 0
            },
        },
        lualine_b = {
            {
                "filename",
                color = { fg = "", bg = "none" },
            },
            {
                "searchcount",
                color = { fg = "#ebbcba", bg = "none" },
            }
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {
            {
                "progress",
                color = {fg = "", bg = "none"},
            }
        },
        lualine_z = {
            {
                "location",
                color = {fg = "", bg = "none"},
                padding = 0
            }
        }
    },
})

