local gruvbox_colors = O.gruvbox_colors
local lsp = require("feline.providers.lsp")
local vi_mode_utils = require("feline.providers.vi_mode")

local b = vim.b
local fn = vim.fn

local colors = {
    -- bg = gruvbox_colors.bg4,
    bg = gruvbox_colors.bg2,
    black = gruvbox_colors.bg2,
    yellow = "#d8a657",
    cyan = "#89b482",
    oceanblue = "#45707a",
    green = "#a9b665",
    orange = "#e78a4e",
    violet = "#d3869b",
    magenta = "#c14a4a",
    white = "#d4be98",
    fg = "#d4be98",
    skyblue = "#7daea3",
    red = "#ea6962",
}

local check_lsp_active_client = function()
    local msg = "No Active Lsp"
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
        return msg
    end
    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return " LSP: " .. client.name
        end
    end
    return msg
end

local icons = {
    linux = " ",
    macos = " ",
    windows = " ",
}

local function file_osinfo()
    local os = vim.loop.os_uname().sysname
    local icon
    if os == "Linux" then
        icon = icons.linux
    elseif os == "Darwin" then
        icon = icons.macos
    else
        icon = icons.windows
    end
    return icon
end
local vi_mode_provider = function()
    return "    "
end

local get_diag = function(str)
    local count = vim.lsp.diagnostic.get_count(0, str)
    return (count > 0) and " " .. count .. " " or ""
end

local percentage_provider = function()
    local cursor = require("feline.providers.cursor")
    return " " .. cursor.line_percentage() .. " "
end

local vi_mode_hl = function()
    return {
        name = vi_mode_utils.get_mode_highlight_name(),
        fg = "bg",
        bg = vi_mode_utils.get_mode_color(),
        style = "bold",
    }
end

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
    get_git_diff = function()
        return vim.b.gitsigns_status_dict ~= nil
    end,
}
local components = {
    active = {},
    inactive = {},
}

components.active[1] = {
    {
        provider = vi_mode_provider,
        hl = vi_mode_hl,
        right_sep = { str = "right_filled" },
    },
    {
        provider = "file_info",
        left_sep = " ",
        right_sep = { str = "vertical_bar", hl = { fg = "fg", bg = "bg" } },
        -- opts = {
        type = "relative",
        -- },
    },
    {
        provider = "file_size",
        enabled = function()
            return fn.getfsize(fn.expand("%:p")) > 0 and vim.fn.winwidth(0) > 80
        end,
        left_sep = " ",
        right_sep = {
            " ",
            {
                str = "vertical_bar",
                hl = {
                    fg = "fg",
                    bg = "bg",
                },
            },
        },
    },
    {
        provider = "position",
        hl = { fg = "violet", bg = "black" },
        left_sep = " ",
        right_sep = " ",
    },
    {
        provider = "┃ ",
    },
    {
        provider = "git_branch",
        hl = {
            fg = "white",
            bg = "black",
            style = "bold",
        },
        right_sep = function()
            local val = { hl = { fg = "NONE", bg = "black" } }
            if b.gitsigns_status_dict then
                val.str = " "
            else
                val.str = ""
            end
            return val
        end,
        enabled = conditions.hide_in_width,
    },
    { provider = "git_diff_added", hl = { fg = "green" } },
    { provider = "git_diff_changed", hl = { fg = "yellow" } },
    { provider = "git_diff_removed", hl = { fg = "red" } },
}

components.active[2] = {
    {
        provider = check_lsp_active_client,
        enabled = conditions.hide_in_width,
        right_sep = " "
    },
    }
components.active[3] = {
    {
        provider = "diagnostic_errors",
        hl = { fg = "red" },
    },
    {
        provider = "diagnostic_warnings",
        hl = { fg = "yellow" },
    },
    {
        provider = "diagnostic_hints",
        hl = { fg = "cyan" },
    },
    {
        provider = "diagnostic_info",
        hl = { fg = "skyblue" },
    },
    { provider = "file_type", left_sep = " ", enabled = conditions.hide_in_width },
    {
        provider = "file_encoding",
        left_sep = " ",
        enabled = conditions.hide_in_width,
    },
    {
        provider = file_osinfo,
        left_sep = " ",
        hl = {
            style = "bold",
        },
        enabled = conditions.hide_in_width,
    },
    {
        provider = "line_percentage",
        hl = {
            style = "bold",
        },
        left_sep = "  ",
        right_sep = " ",
    },
    {
        provider = "scroll_bar",
        hl = {
            fg = "skyblue",
            style = "bold",
        },
    },
}

components.inactive[1] = {
    {
        provider = "file_info",
        hl = {
            fg = "white",
            bg = "oceanblue",
            style = "bold",
        },
        left_sep = {
            str = " ",
            hl = {
                fg = "NONE",
                bg = "oceanblue",
            },
        },
        right_sep = {
            {
                str = " ",
                hl = {
                    fg = "NONE",
                    bg = "oceanblue",
                },
            },
            "slant_right",
        },
    },
}

-- This table is equal to the default separators table
local separators = {
    vertical_bar = "┃",
    vertical_bar_thin = "│",
    left = "",
    right = "",
    block = "█",
    left_filled = "",
    right_filled = "",
    slant_left = "",
    slant_left_thin = "",
    slant_right = "",
    slant_right_thin = "",
    slant_left_2 = "",
    slant_left_2_thin = "",
    slant_right_2 = "",
    slant_right_2_thin = "",
    left_rounded = "",
    left_rounded_thin = "",
    right_rounded = "",
    right_rounded_thin = "",
    circle = "●",
}

-- This table is equal to the default vi_mode_colors table
local vi_mode_colors = {
    ["NORMAL"] = "green",
    ["OP"] = "green",
    ["INSERT"] = "red",
    ["VISUAL"] = "yellow",
    ["LINES"] = "skyblue",
    ["BLOCK"] = "skyblue",
    ["REPLACE"] = "violet",
    ["V-REPLACE"] = "violet",
    ["ENTER"] = "cyan",
    ["MORE"] = "cyan",
    ["SELECT"] = "orange",
    ["COMMAND"] = "green",
    ["SHELL"] = "green",
    ["TERM"] = "green",
    ["NONE"] = "yellow",
}

-- This table is equal to the default force_inactive table
local force_inactive = {
    filetypes = {
        "NvimTree",
        "packer",
        "startify",
        "fugitive",
        "fugitiveblame",
        "qf",
        "help",
    },
    buftypes = {
        "terminal",
    },
    bufnames = {},
}

-- This table is equal to the default disable table
local disable = {
    filetypes = {},
    buftypes = {},
    bufnames = {},
}

-- This table is equal to the default update_triggers table
local update_triggers = {
    "VimEnter",
    "WinEnter",
    "WinClosed",
    "FileChangedShellPost",
}

require("feline").setup({
    colors = colors,
    separators = separators,
    vi_mode_colors = vi_mode_colors,
    force_inactive = force_inactive,
    disable = disable,
    update_triggers = update_triggers,
    components = components,
})
