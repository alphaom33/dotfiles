local oil_constant = require("oil.constants")
local oil_column = require("oil.columns")

local FIELD_TYPE = oil_constant.FIELD_TYPE
local FIELD_NAME = oil_constant.FIELD_NAME

local function get_extension(filename)
    return vim.fn.fnamemodify(filename, ":e")
end

local priority_extensions = {
    py = 0,
    c = 0,
    cpp = 0,
    h = 0,
    hs = 0,
    java = 0,
    ts = 0,
    js = 0,
    go = 0,
    rs = 0,
    gradle = 1,
    ks = 1,
    html = 1,
    css = 2,
    sh = 3,
    xml = 9,
    txt = 9,
    cabal = 9,
    json = 9,
}

oil_column.register("extension", {
    render = function(entry, _)
        if entry[FIELD_TYPE] == "file" and entry[FIELD_NAME] then
            return get_extension(entry[FIELD_NAME])
        end
    end,
    parse = function(line, _)
        return line:match("^(%S+)%s+(.*)$")
    end,
    create_sort_value_factory = function(_)
        local memo = {}
        return function(entry)
            if memo[entry] == nil then
                if entry[FIELD_TYPE] == "file" and entry[FIELD_NAME] then
                    local ex = get_extension(entry[FIELD_NAME]):lower()
                    if ex ~= "" then
                        memo[entry] = (priority_extensions[ex] or "") .. ex
                    else
                        memo[entry] = "z"
                    end
                else
                    memo[entry] = ""
                end
            end
            return memo[entry]
        end
    end,
})

require("oil").setup({
    skip_confirm_for_simple_edits = true,
    delete_to_trash = true,
    view_options = {
        show_hidden = true,
        sort = {
            { "type", "asc" },
            { "extension", "asc" },
            { "name", "asc" },
        },
        is_always_hidden = function (name, _)
            return name == ".."
        end,
    },
    keymaps = {
        ["gp"] = "actions.preview",
    },
    lsp_file_methods = {
        autosave_changes = true,
    },
})

vim.keymap.set("n", "-", function ()
    vim.cmd.wall({ mods = { silent = true, emsg_silent = true } })
    vim.cmd("Oil")
end, { desc = "Open parent directory" })
