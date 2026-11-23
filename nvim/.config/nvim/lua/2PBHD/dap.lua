local dap = require('dap')

vim.keymap.set('n', '<F5>', ':DapNew<CR>', { silent = true, desc = "New" })
vim.keymap.set('n', '<Leader>dc', dap.continue, { desc = "Continue"})
vim.keymap.set('n', '<F10>', dap.step_over, { desc = "Step Over" })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = "Step Into" })
vim.keymap.set('n', '<F12>', dap.step_out, { desc = "Step Out" })
vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set('n', '<Leader>B', dap.set_breakpoint, { desc = "Set Breakpoint" })
vim.keymap.set('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = "Set Log Point" })
vim.keymap.set('n', '<Leader>dr', function () dap.repl.toggle({ height = 10 }) end, { silent = true, desc = "Toggle Repl" })
vim.keymap.set('n', '<Leader>dl', dap.run_last, { desc = "Run Last" })
vim.keymap.set('n', '<Leader>de', function()
    dap.terminate()
    dap.close()
end, { desc = "Kill Debugger" })

vim.keymap.set({'n', 'v'}, '<Leader>dh', require('dap.ui.widgets').hover, { desc = "Hover" })
vim.keymap.set({'n', 'v'}, '<Leader>dp', require('dap.ui.widgets').preview, { desc = "Preview" })

vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end, { desc = "Frames" })

vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end, { desc = "Scopes" })

vim.cmd("hi DapBreakpointColor guifg=#fa4848")
vim.fn.sign_define('DapBreakpoint', {text='󰝥', texthl='DapBreakpointColor', linehl='', numhl=''})


dap.adapters["local-lua"] = {
    type = "executable",
    command = "node",
    args = {
        "/home/ltuser/.local/share/nvim/mason/share/local-lua-debugger-vscode/extension/debugAdapter.js"
    },
    enrich_config = function(config, on_config)
        if not config["extensionPath"] then
            local c = vim.deepcopy(config)
            c.extensionPath = "/home/ltuser/.local/share/nvim/mason/share/local-lua-debugger-vscode"
            on_config(c)
        else
            on_config(config)
        end
    end,

}
dap.configurations.lua = {
    {
        type = 'local-lua',
        request = 'launch',
        name = 'Launch file',
        program = {
            lua = 'lua',
            file = '${file}',
        },
        cwd = '${workspaceFolder}',
    }
}

dap.adapters.python = function(cb, config)
    if config.request == 'attach' then
        local port = (config.connect or config).port
        local host = (config.connect or config).host or '127.0.0.1'
        cb({
            type = 'server',
            port = assert(port, '`connect.port` is required for a python `attach` configuration'),
            host = host,
            options = {
                source_filetype = 'python'
            },
        })
    else
        cb({
            type = 'executable',
            command = '/home/ltuser/.local/share/nvim/mason/packages/debugpy/venv/bin/python',
            args = { '-m', 'debugpy.adapter'},
            options = {
                source_filetype = 'python',
            },
        })
    end
end
dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                return cwd .. '/venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                return cwd .. '/.venv/bin/python'
            else
                return '/usr/bin/python3'
            end
        end,
    },
}

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "/home/ltuser/.local/share/nvim/mason/bin/codelldb",
        args = {"--port", "${port}"}
    }
}
local executablePath = ""
local lldb_config = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function ()
            if executablePath == "" then
                executablePath = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end
            return executablePath
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {}
    }
}
dap.configurations.c = lldb_config
dap.configurations.cpp = lldb_config
dap.configurations.rust = lldb_config
