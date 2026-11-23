require("rose-pine").setup({
  styles = {
    transparency = true,
  },
  highlight_groups = {
    StatusLine = { bg = "none" },
    StatusLineNC = { bg = "none" },
  },
})

vim.cmd("colorscheme rose-pine")

vim.api.nvim_set_hl(0, "OilFileHidden", { link = "OilFile" })
vim.api.nvim_set_hl(0, "OilDirHidden", { link = "OilDir" })

vim.opt.showmode = false
vim.opt.cmdheight = 0
vim.opt.fillchars:append({
    stl = " ",
    stlnc = " ",
})

vim.opt.winborder = "single"
vim.opt.pumborder = "single"
vim.opt.pumheight = 10
