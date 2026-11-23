return {
	"folke/which-key.nvim",
	"https://github.com/fedepujol/move.nvim",
	"williamboman/mason-lspconfig.nvim",
	"mfussenegger/nvim-jdtls",
    "tpope/vim-surround",
    "stevearc/oil.nvim",
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },
    {
        "malewicz1337/oil-git.nvim",
        dependencies = { "stevearc/oil.nvim" }
    },
    {
        "JezerM/oil-lsp-diagnostics.nvim",
        dependencies = { "stevearc/oil.nvim" },
        opts = {}
    },
    "ms-jpq/coq_nvim",
}
