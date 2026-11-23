vim.g.mapleader = " "

vim.keymap.set("n", "<A-t>", function ()
	vim.cmd.edit("term://bash")
end)
vim.keymap.set("t", "<Esc>", function ()
	vim.cmd("bd!")
end)

--why do I have to add these help they should work on their own but they don't
vim.keymap.set({"n", "v"}, "<S-Insert>", "\"+p", { noremap = true })
vim.keymap.set("i", "<S-Insert>", "<C-o>\"+p", { noremap = true })
vim.keymap.set({"n", "v"}, "<C-Insert>", "\"+y", { noremap = true })

vim.keymap.set({"n"}, "<C-d>", vim.cmd.Dashboard, { noremap = true })

vim.keymap.set({"n", "v"}, "zn", function ()
    vim.cmd.noh()
    require("lualine").refresh()
end, { noremap = true, desc = "disable highlights" })

vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = "check diagnostics" })

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function ()
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "go to definition" })
    end
})

vim.keymap.set("i", "<S-Tab>", function()
  if vim.fn.complete_info()["selected"] ~= -1 then
      return "<C-y>"
  elseif vim.fn.pumvisible() ~= 0 then
      return "<C-n><C-y>"
  end
end, { expr = true, noremap = false })

vim.keymap.set("i", "<Tab>", function()
  if vim.fn.pumvisible() ~= 0 then return "<C-n>" end
  return "<Tab>"
end, { expr = true })

vim.keymap.set("n", "gh", function ()
    vim.cmd("LspClangdSwitchSourceHeader")
end, { desc = "switch source header" })

vim.api.nvim_set_keymap('i', '<Esc>', [[pumvisible() && complete_info().selected == -1 ? "\<C-y><Esc>" : "\<Esc>"]], { expr = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-c>', [[pumvisible() ? "\<C-y><C-c>" : "\<C-c>"]], { expr = true, silent = true })

local autopair = require("2PBHD.autopair")
vim.keymap.set(
    "i",
    "<CR>",
    function()
        local curpos = vim.fn.getpos(".")
        local indent = vim.fn.indent(".")
        local line = vim.api.nvim_get_current_line()
        local cur = line:sub(curpos[3] - 1, curpos[3] - 1)
        local next = line:sub(curpos[3], curpos[3])
        if autopair.delimiters[cur] and next == autopair.delimiters[cur] then

            vim.schedule(function ()
                vim.fn.append(curpos[2], string.rep(" ", indent + 4))
                vim.fn.cursor(curpos[2] + 1, curpos[3] + 3)
            end)
        end

        if vim.fn.pumvisible() == 1 then
            if vim.fn.complete_info().selected == -1 then
                return "<C-e><CR>"
            else
                return "<C-y>"
            end
        else
            return "<CR>"
        end
    end,
    { expr = true, silent = true }
)

vim.api.nvim_set_keymap('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<BS>"]], { expr = true, silent = true })
