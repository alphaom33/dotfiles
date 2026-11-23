pcall(function ()
    local builtin = require("telescope.builtin")

    vim.keymap.set('n', '<leader>pd', builtin.find_files, { desc = "dumb search" })
    vim.keymap.set('n', '<leader>pf', function ()
        vim.cmd.wall({ mods = { silent = true, emsg_silent = true } })
        builtin.git_files()
    end, { desc = "find files" })

    vim.keymap.set('n', '<leader>ps', function ()
        vim.cmd.wall({ mods = { silent = true, emsg_silent = true } })
        builtin.live_grep()
    end, { desc = "grep" })
end)
