return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
        branch = "main",
        lazy = false,
	},
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        priority = 49,
    },
	"tpope/vim-fugitive",
	"https://github.com/lewis6991/gitsigns.nvim",
}
