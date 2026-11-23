-- vim.cmd("syntax match PythonCustomClass /\\<[A-Z]\\w*\\>/")
-- vim.api.nvim_set_hl(0, "PythonCustomClass", { link = "Structure" })
-- vim.api.nvim_set_hl(0, "PythonBoolean", { link = "Boolean" })
vim.api.nvim_set_hl(0, "@lsp.type.namespace.python", { link = "Include" })

