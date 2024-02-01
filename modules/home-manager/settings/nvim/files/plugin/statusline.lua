local function get_current_branch()
    local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
    if branch ~= "" then
        return branch
    else
        return ""
    end
end

local function statusline()
    local gitbranch = get_current_branch()
    local filepath = vim.fn.expand('%f')
    local filetype = vim.bo.filetype

    return table.concat {
        '%=',
        string.format("[Git(%s)]", gitbranch),
        ' ',
        filepath,
        ' ',
        string.format("[%s]", filetype)
    }
end

vim.o.laststatus=3

vim.api.nvim_create_autocmd({"WinEnter", "BufEnter", "BufRead", "BufNew"}, {
    pattern = {"*"},
    callback = function()
        vim.o.statusline=statusline()
    end
})
