local mark_ns = vim.api.nvim_create_namespace("saddenedDelims")

local colors = {"#eb6f92", "#f6c177","#9ccfd8", "#31748f", "#c4a7e7"}
for i, c in ipairs(colors) do
    vim.api.nvim_set_hl(0, "SadDelims" .. tostring(i), {
        fg = c,
    })
end

for _, id in pairs(vim.api.nvim_buf_get_extmarks(0, mark_ns, 0, -1, {})) do
    vim.api.nvim_buf_del_extmark(0, mark_ns, id[1])
end

vim.api.nvim_create_augroup("SadDelimsGroup", { clear = true })

local open = ("("):byte(1)
local close = (")"):byte(1)
local strs = {
    [("\""):byte(1)] = true,
    [("'"):byte(1)] = true,
}
local back = ("\\"):byte(1)

local function checkbuf(lines)
    for _, mark in pairs(vim.api.nvim_buf_get_extmarks(0, mark_ns, 0, -1, {})) do
        vim.api.nvim_buf_del_extmark(0, mark_ns, mark[1])
    end

    local opens = 0
    local stred = nil
    for row, line in ipairs(lines) do
        for col = 1, #line do
            local char = line:byte(col)

            if strs[char]
                and (not stred or stred == char)
                and (
                    col == 1
                    or line:byte(col - 1) ~= back
                    or (col > 2 and line:byte(col - 2) == back)
                ) then
                if stred == nil then
                    stred = char
                else
                    stred = nil
                end
            end

            local add_mark = true

            if not stred then
                if char == open then
                    opens = opens + 1
                elseif char == close then
                else
                    add_mark = false
                end

                if add_mark then
                    if opens > 0 then
                        vim.api.nvim_buf_set_extmark(0, mark_ns, row - 1, col - 1, {
                            end_col = col,
                            hl_group = "SadDelims" .. tostring(opens),
                            priority = 300
                        })
                    end
                end

                if char == close then
                    opens = opens - 1
                end
            end
        end
    end
end

vim.api.nvim_create_autocmd("BufEnter", {
    group = "SadDelimsGroup",
    callback = function ()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        checkbuf(lines)
    end,
})

vim.api.nvim_create_autocmd("TextChanged", {
    group = "SadDelimsGroup",
    callback = function ()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        checkbuf(lines)
    end,
})

vim.api.nvim_create_autocmd("InsertCharPre", {
    group = "SadDelimsGroup",
    callback = function ()
        if vim.v.char == "(" or vim.v.char == ")" then
            vim.schedule(function ()
                local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
                checkbuf(lines)
            end)

        end
    end,
})
