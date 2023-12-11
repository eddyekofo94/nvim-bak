return {
  "glepnir/dashboard-nvim",
  event = "VimEnter",
  config = function()
    require("dashboard").setup({
      theme = "hyper",
      config = {
        week_header = {
          enable = true,
        },
        -- header = {
        --   "     ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        --   "     ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        --   "     ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        --   "     ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        --   "     ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        --   "     ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        -- }, --your header
        change_to_vcs_root = true,
        hide = {
          "number",
          "relativenumber",
          "listchars",
          "statusline", -- hide statusline default is true
          tabline = true, -- hide the tabline
          winbar = true, -- hide winbar
        },
        footer = {
          "'...as to the Lord, and not unto men'-Colossians 3:23",
        },
      },
    })
  end,
}
