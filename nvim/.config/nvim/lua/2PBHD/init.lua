require("2PBHD.remap")
require("2PBHD.appearance")
require("2PBHD.lsp")
require("2PBHD.delete-windows")
require("2PBHD.dap")
require("2PBHD.oil")
require("2PBHD.lualine")
require("2PBHD.autopair")
require("2PBHD.rainbow_delimiters")

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.undofile = true
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.cmd.set("formatoptions-=cro")
    end
})
vim.opt.expandtab = true

vim.opt.scrolloff = 5

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.updatetime = 50

vim.opt.splitright = true

require('vim._core.ui2').enable({
  enable = true, -- Whether to enable or disable the UI.
  msg = { -- Options related to the message module.
    ---@type 'cmd'|'msg' Default message target, either in the
    ---cmdline or in a separate ephemeral message window.
    ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
    ---or table mapping |ui-messages| kinds and triggers to a target.
    targets = "msg",
    cmd = { -- Options related to messages in the cmdline window.
      height = 0.5 -- Maximum height while expanded for messages beyond 'cmdheight'.
    },
    dialog = { -- Options related to dialog window.
      height = 1, -- Maximum height.
    },
    msg = { -- Options related to msg window.
      height = 0.5, -- Maximum height.
      timeout = 4000, -- Time a message is visible in the message window.
    },
    pager = { -- Options related to message window.
      height = 1, -- Maximum height.
    },
  },
})

vim.api.nvim_create_autocmd("FocusLost", {
    callback = function ()
        vim.cmd.wall({mods = {silent = true, emsg_silent = true}})
    end
})

vim.api.nvim_create_user_command("Q", function ()
    vim.cmd("silent! wa")
    vim.cmd("silent! q")
end, {})
