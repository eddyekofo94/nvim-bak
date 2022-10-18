local gruvbox_colors = O.gruvbox_colors
local onedark_colors = O.onedark_colors
local lsp = require("feline.providers.lsp")
local git = require("feline.providers.git")
local vi_mode_utils = require("feline.providers.vi_mode")

local b = vim.b
local g = vim.g
local fn = vim.fn

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

local get_diag = function(str)
    local count = vim.diagnostic.get(0, str)
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

local vi_bg = function()
    return {
        fg = "bg",
        style = "bold",
        bg = vi_mode_utils.get_mode_color(),
    }
end
local vi_fg = function()
    return {
        fg = vi_mode_utils.get_mode_color(),
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

local vi_mode_provider = function()
    if conditions.check_git_workspace then
        return git.git_branch
    end
end

local components = {
    active = {},
    inactive = {},
}

components.active[1] = {
    {
        -- provider = vi_mode_provider,
        provider = "  ",
        hl = vi_mode_hl,
        right_sep = { str = " ", hl = vi_bg },
        left_sep = { str = " ", hl = vi_bg },
    },
    {
        provider = "git_branch",
        left_sep = {
            str = " ",

            hl = {

                fg = "fg",
                bg = "fg_gutter",
            },
        },
        hl = {

            fg = "fg",
            bg = "fg_gutter",
        },
    },
    {
        provider = "file_size",
        enabled = function()
            return fn.getfsize(fn.expand("%:p")) > 0 and vim.fn.winwidth(0) > 80
        end,
        hl = {

            fg = "fg",
            bg = "fg_gutter",
        },
        left_sep = {
            {
                str = " ",
                hl = {
                    fg = "bg",
                    bg = "fg_gutter",
                },
            },
        },
    },
    {
        provider = " ",
        hl = {
            fg = "bg",
            bg = "fg_gutter",
        },
    },
    {
        provider = {
            name = "file_info",
            opts = {
                type = "relative",
            },
        },
        hl = function()
            return {
                fg = require("feline.providers.vi_mode").get_mode_color(),
            }
        end,
        left_sep = " ",
        right_sep = function()
            local val = { hl = { fg = "bg", bg = "bg" } }
            if b.gitsigns_status_dict then
                val.str = " "
            else
                val.str = ""
            end
            return val
        end,
        type = "relative",
    },
    { provider = "git_diff_added", hl = { fg = onedark_colors.add } },
    { provider = "git_diff_changed", hl = { fg = onedark_colors.change } },
    { provider = "git_diff_removed", hl = { fg = onedark_colors.delete } },
}

components.active[2] = {
    {
        provider = check_lsp_active_client,
        hl = vi_fg,
        enabled = conditions.hide_in_width,
        right_sep = " ",
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
    {
        provider = " ",
        hl = {
            bg = "bg",
        },
    },
    {
        provider = "file_type",
        hl = vi_bg,
        left_sep = { str = " ", hl = vi_bg },
        enabled = conditions.hide_in_width,
    },
    {
        provider = "file_encoding",
        left_sep = { str = " ", hl = vi_bg },
        hl = vi_bg,
        enabled = conditions.hide_in_width,
    },
    {
        provider = file_osinfo,
        left_sep = { str = " ", hl = vi_bg },
        hl = vi_bg,
        enabled = conditions.hide_in_width,
    },
    {
        provider = "position",
        hl = {
            fg = "bg",
            bg = "skyblue",
            style = "bold",
        },
        left_sep = {
            {
                str = " ",
                hl = {
                    fg = "bg",
                    bg = "skyblue",
                },
            },
        },
        right_sep = {
            {
                str = " ",
                hl = {
                    fg = "bg",
                    bg = "skyblue",
                },
            },
        },
    },
    {
        provider = "line_percentage",
        hl = vi_bg,
        left_sep = { str = " ", hl = vi_bg },
        right_sep = { str = " ", hl = vi_bg },
    },
    {
        provider = "scroll_bar",
        hl = vi_fg,
    },
}

components.inactive[1] = {
    {
        provider = {
            name = "file_info",
            opts = {
                type = "relative",
            },
        },
        hl = {
            fg = "fg",
            style = "bold",
        },
        left_sep = {
            str = " ",
            hl = {
                fg = "NONE",
            },
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
    colors = onedark_colors,
    separators = separators,
    vi_mode_colors = vi_mode_colors,
    force_inactive = force_inactive,
    disable = disable,
    update_triggers = update_triggers,
    components = components,
})
