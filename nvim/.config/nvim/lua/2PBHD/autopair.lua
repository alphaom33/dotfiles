M = {
    delimiters = {
        ["{"] = "}",
        ["["] = "]",
        ["("] = ")",
    },
}

local all_delimiters = {
    ["\""] = "\"",
}
for k, v in pairs(M.delimiters) do
    all_delimiters[k] = v
end

local sad = {
    ["\""] = "\\"
}

local delimiter_queue_length = 0
local delimiter_queue = {}

local function add_delimiter(delimiter)
    delimiter_queue_length = delimiter_queue_length + 1
    delimiter_queue[delimiter_queue_length] = delimiter
end

local function pop_delimiter()
    delimiter_queue_length = delimiter_queue_length - 1
end

local function is_alphanum(char)
    return
        char:byte() ~= nil and
        (('a'):byte() < char:byte() and char:byte() < ('z'):byte() or
        ('A'):byte() < char:byte() and char:byte() < ('Z'):byte() or
        ('0'):byte() < char:byte() and char:byte() < ('9'):byte()) or
        M.delimiters[char]
end

vim.api.nvim_create_augroup("AnnoyedAutopair", { clear = true })
vim.api.nvim_create_autocmd("InsertCharPre", {
    group = "AnnoyedAutopair",
    callback = function (_)
        local curpos = vim.fn.getpos(".")
        local line = vim.api.nvim_get_current_line()
        local char = vim.v.char
        local last = line:sub(curpos[3] - 1, curpos[3] - 1)
        local next = line:sub(curpos[3], curpos[3])
        if last ~= sad[char] then
            if char == delimiter_queue[delimiter_queue_length] then
                vim.schedule(function()
                    pop_delimiter()
                    vim.api.nvim_set_current_line(line)
                end)
            elseif all_delimiters[char] and not is_alphanum(next) then
                vim.schedule(function()
                    add_delimiter(all_delimiters[char])
                    local out = line:sub(1, curpos[3] - 1) .. char .. all_delimiters[char] .. line:sub(curpos[3], line:len())
                    vim.api.nvim_set_current_line(out)
                end)
            end
        end
    end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    group = "AnnoyedAutopair",
    callback = function (_)
        delimiter_queue_length = 0
    end
})

return M
