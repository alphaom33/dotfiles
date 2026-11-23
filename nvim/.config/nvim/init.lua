vim.env.TERM = "vte-256colors"

require("config.lazy")
require("2PBHD")
require("gitsigns").setup()
require("nvim-treesitter").install({
    "c", "cpp", "lua","rust", "tsx", "typescript", "vim",
    "markdown", "bash", "html", "css", "clojure", "vimdoc",
    "java", "typst"
})
vim.diagnostic.config({
    severity_sort = true
})

vim.cmd("let hs_highlight_delimiters = 1")
vim.cmd("let hs_highlight_boolean = 1")
vim.cmd("let hs_highlight_types = 1")
vim.cmd("let hs_highlight_even_more_types = 1")

local borders =  { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
require("telescope").setup({
    defaults = {
        borderchars = {
            prompt = borders,
            results = borders,
            preview = borders,
        }
    }
})

