vim.lsp.config("glslls", {
    cmd = { 'glslls', "--target-env", "opengl", '--stdin' },
    filetypes = { 'glsl', 'vert', 'tesc', 'tese', 'frag', 'geom', 'comp' },
    root_markers = { '.git' },
    capabilities = {
        textDocument = {
            completion = {
                editsNearCursor = true,
            },
        },
        offsetEncoding = { 'utf-8', 'utf-16' },
    },
})

vim.opt.dictionary:append({"/usr/share/dict/words"})
vim.opt.completeopt = {"menuone", "noselect", "popup"}
vim.opt.shortmess:append("c")
vim.opt.autocompletetimeout = 200

vim.g.coq_settings = {
    keymap = {
        recommended = false,
    },
    display = {
        preview = {
            border = "single",
        },
    },
    weights = {
        recency = 1.1,
    },
    clients = {
        lsp = {
            weight_adject = 1.05
        },
    },
    completion = {
        skip_after = {"\t", " "},
    },
}

local coq = require("coq")
coq.setup({})

require('mason').setup({})
require('mason-lspconfig').setup({})
