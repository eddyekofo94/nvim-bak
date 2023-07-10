local colors = require("catppuccin.palettes").get_palette() -- fetch colors from palette
local colors = {
    -- fg = "#76787d",
    -- bg = "#252829",
    fg = colors.fg,
    bg = colors.bg,
}

function GitBranch()
    local ok, _ = os.rename(vim.fn.getcwd() .. '/.git', vim.fn.getcwd() .. '/.git')
    if not ok then
        return ''
    end

    local fp = io.popen('git branch --show-current')
    local branch = fp:read('*a')
    if not branch then
        return ''
    end

    branch = string.gsub(branch, '\n', '')
    return [[ ]] .. branch
end

function LSPStatus()
    local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })

    if errors > 0 then
        return '  ' .. errors .. ' '
    elseif warnings > 0 then
        return '  ' .. warnings .. ' '
    else
        return ''
    end
end

function StatusLine()
    local status = ''

    -- left side
    status = status .. [[ %-{luaeval("GitBranch()")}]]
    status = status .. [[ %-F]]
    status = status .. [[ %{luaeval("LSPStatus()")}]]
    -- right side
    status = status .. [[ %= %y LN %l/%L]]

    return status
end

vim.wo.statusline = '%!luaeval("StatusLine()")'
vim.api.nvim_set_hl(0, "StatusLine", { bg = colors.bg, fg = colors.fg })
