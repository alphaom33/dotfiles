return {
	{
        'neovim/nvim-lspconfig',
        lazy = false,
        dependencies = {
            { "ms-jpq/coq_nvim", branch = "coq" },
            { "ms-jpq/coq.artifacts", branch = "artifacts" }
        }
    },
    { 'mfussenegger/nvim-dap' },
    {
        'MrcJkb/haskell-tools.nvim',
        lazy = false,
    },
}
