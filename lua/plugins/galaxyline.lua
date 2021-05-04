local gl = require("galaxyline")
-- get my theme in galaxyline repo
-- local colors = require('galaxyline.theme').default
local colors = {
    -- bg = '#2E2E2E',
    bg = "#1f2335",
    fg = "#c0caf5",
    yellow = "#e0af68",
    dark_yellow = "#D7BA7D",
    cyan = "#4EC9B0",
    green = "#9ece6a",
    light_green = "#73daca",
    string_orange = "#CE9178",
    orange = "#ff9e64",
    purple = "#9d7cd8",
    magenta = "#bb9af7",
    grey = "#858585",
    blue = "#7aa2f7",
    vivid_blue = "#4FC1FF",
    light_blue = "#9CDCFE",
    red = "#f7768e",
    error_red = "#F44747",
    info_yellow = "#FFCC66",
    comment = "#565f89"
}
local condition = require("galaxyline.condition")
local gls = gl.section
gl.short_line_list = {"NvimTree", "vista", "dbui", "packer"}

gls.left[1] = {
    ViMode = {
        provider = function()
            -- auto change color according the vim mode
            local mode_color = {
                n = colors.blue,
                i = colors.green,
                v = colors.purple,
                [""] = colors.purple,
                V = colors.purple,
                c = colors.magenta,
                no = colors.blue,
                s = colors.orange,
                S = colors.orange,
                [""] = colors.orange,
                ic = colors.yellow,
                R = colors.red,
                Rv = colors.red,
                cv = colors.blue,
                ce = colors.blue,
                r = colors.cyan,
                rm = colors.cyan,
                ["r?"] = colors.cyan,
                ["!"] = colors.blue,
                t = colors.blue
            }
            vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
            return "▊ "
        end,
        highlight = {colors.red, colors.bg}
    }
}
print(vim.fn.getbufvar(0, "ts"))
vim.fn.getbufvar(0, "ts")

gls.left[2] = {
    FileIcon = {
        provider = "FileIcon",
        condition = condition.buffer_not_empty,
        highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg}
    }
}

gls.left[3] = {
    FileName = {
        provider = "FileName",
        condition = condition.buffer_not_empty,
        highlight = {colors.orange, colors.bg}
    }
}

gls.left[4] = {
    LineInfo = {
        provider = "LineColumn",
        separator = "  ",
        separator_highlight = {"NONE", colors.bg},
        highlight = {colors.fg, colors.bg}
    }
}

gls.left[5] = {
    PerCent = {
        provider = "LinePercent",
        separator = " ",
        separator_highlight = {"NONE", colors.bg},
        highlight = {colors.fg, colors.bg}
    }
}

gls.right[1] = {
    DiagnosticError = {provider = "DiagnosticError", icon = "  ", highlight = {colors.error_red, colors.bg}}
}
gls.right[2] = {DiagnosticWarn = {provider = "DiagnosticWarn", icon = "  ", highlight = {colors.orange, colors.bg}}}

gls.right[3] = {
    DiagnosticHint = {provider = "DiagnosticHint", icon = "  ", highlight = {colors.vivid_blue, colors.bg}}
}

gls.right[4] = {
    DiagnosticInfo = {provider = "DiagnosticInfo", icon = "  ", highlight = {colors.info_yellow, colors.bg}}
}

gls.right[5] = {
    ShowLspClient = {
        provider = "GetLspClient",
        condition = function()
            local tbl = {["dashboard"] = true, [" "] = true}
            if tbl[vim.bo.filetype] then
                return false
            end
            return true
        end,
        icon = " ",
        highlight = {colors.comment, colors.bg}
    }
}


gls.right[8] = {
    GitIcon = {
        provider = function()
            return " "
        end,
        condition = condition.check_git_workspace,
        separator = " ",
        separator_highlight = {"NONE", colors.bg},
        highlight = {colors.orange, colors.bg}
    }
}

gls.right[9] = {
    GitBranch = {
        provider = "GitBranch",
        condition = condition.check_git_workspace,
        separator = " ",
        separator_highlight = {"NONE", colors.bg},
        highlight = {colors.fg, colors.bg}
    }
}

gls.right[10] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = condition.hide_in_width,
        separator = " ",
        icon = "  ",
        highlight = {colors.green, colors.bg}
    }
}
gls.right[11] = {
    DiffModified = {
        provider = "DiffModified",
        condition = condition.hide_in_width,
        icon = " 柳",
        highlight = {colors.blue, colors.bg}
    }
}
gls.right[12] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = condition.hide_in_width,
        icon = "  ",
        highlight = {colors.red, colors.bg}
    }
}
gls.right[13] = {
    BufferType = {
        provider = "FileTypeName",
        condition = condition.hide_in_width,
        separator = " | ",
        separator_highlight = {"NONE", colors.bg},
        highlight = {colors.comment, colors.bg}
    }
}

gls.right[14] = {
    FileEncode = {
        provider = "FileEncode",
        condition = condition.hide_in_width,
        separator = " ",
        separator_highlight = {"NONE", colors.bg},
        highlight = {colors.comment, colors.bg}
    }
}

gls.right[15] = {
    Space = {
        provider = function()
            return " "
        end,
        separator = " ",
        separator_highlight = {"NONE", colors.bg},
        highlight = {colors.orange, colors.bg}
    }
}

gls.short_line_left[1] = {
    BufferType = {
        provider = "FileTypeName",
        separator = " ",
        separator_highlight = {"NONE", colors.bg},
        highlight = {colors.fg, colors.bg}
    }
}

gls.short_line_left[2] = {
    SFileName = {provider = "SFileName", condition = condition.buffer_not_empty, highlight = {colors.fg, colors.bg}}
}

gls.short_line_right[1] = {BufferIcon = {provider = "BufferIcon", highlight = {colors.fg, colors.bg}}}
