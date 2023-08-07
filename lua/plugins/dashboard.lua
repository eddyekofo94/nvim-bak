return {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            theme = 'hyper',
            config = {
                header = {
                    "     ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
                    "     ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
                    "     ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
                    "     ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
                    "     ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
                    "     ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
                }, --your header
                change_to_vcs_root = true,
                hide = {
                    "number",
                    "relativenumber",
                    "listchars",
                    "statusline", -- hide statusline default is true
                    tabline = true,    -- hide the tabline
                    winbar = true,     -- hide winbar
                },
                footer = {
                    "2 Timothy 2:15",
                },
            },
        }
    end,
}
