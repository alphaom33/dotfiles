vim.opt.shiftwidth = 8
vim.opt.tabstop = 8
vim.opt.expandtab = false
vim.bo.commentstring = "* %s"

vim.keymap.set("n", "gcc", function()
    local line = vim.api.nvim_get_current_line()
    if line:sub(1, 1) == "*" then
        vim.api.nvim_set_current_line(line:sub(2))
    else
        vim.api.nvim_set_current_line("*" .. line)
    end
end, { buffer = true })

vim.keymap.set("v", "gc", function()
    local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
    vim.api.nvim_feedkeys(esc, "x", false)
    local start_line = vim.api.nvim_buf_get_mark(0, "<")[1]
    local end_line = vim.api.nvim_buf_get_mark(0, ">")[1]

    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

    for i, line in ipairs(lines) do
        if line:sub(1, 1) == "*" then
            lines[i] = line:sub(2)
        else
            lines[i] = "*" .. line
        end
    end
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
end, { buffer = true })

vim.keymap.set("i", "<Tab>", function()
    local out = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())
    local lnum = out[1] - 1
    local col = out[2]

    local insertion = "\t"
    if vim.fn.virtcol('.') < 8 then
        insertion = insertion .. "\t"
    end
    vim.api.nvim_buf_set_text(vim.api.nvim_get_current_buf(), lnum, col, lnum, col, { insertion })
    vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { lnum + 1, col + #insertion + 1 })
end)
