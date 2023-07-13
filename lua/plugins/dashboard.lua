return {
    "ChristianChiarulli/dashboard-nvim",
    config = function()
        vim.g.dashboard_default_executive = "telescope"

        vim.g.dashboard_custom_header = {
            "     ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
            "     ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
            "     ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
            "     ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
            "     ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
            "     ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        }
        vim.g.dashboard_custom_section = {
            -- a = { description = { "  Load Last Session  " }, command = 'lua require("persistence").load()' },
            a = { description = { "  Load Last Session  " }, command = 'SessionLoad' },
            b = {
                description = { "  Recently Used Files" },
                command = "Telescope oldfiles",
            },
            c = {
                description = { "  Find File          " },
                command = "Telescope find_files",
            },
            d = {
                description = { "  Find Word          " },
                command = "Telescope live_grep",
            },
            -- e = {description = {'  Marks              '}, command = 'Telescope marks'}
        }

        vim.g.dashboard_custom_footer = { "2 Timothy 2:15" }
    end,
}
