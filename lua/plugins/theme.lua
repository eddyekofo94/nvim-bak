return {
    {
        "mcchrish/zenbones.nvim",
        -- Optionally install Lush. Allows for more configuration or extending the colorscheme
        -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
        -- In Vim, compat mode is turned on as Lush only works in Neovim.
        dependencies = "rktjmp/lush.nvim",
        lazy = false,
        config = function()
            -- vim.cmd('colorscheme zenbones')
        end,
    },
    {
        "rose-pine/neovim",
        config = function()
            require("rose-pine").setup({
                --- @usage 'auto'|'main'|'moon'|'dawn'
                variant = "moon",
                --- @usage 'main'|'moon'|'dawn'
                dark_variant = "main",
                disable_italics = true,
                -- vim.cmd('colorscheme rose-pine'),
            })
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        opts = {
            compile = false,  -- enable compiling the colorscheme
            undercurl = true, -- enable undercurls
            commentStyle = { italic = false },
            functionStyle = { italic = false },
            keywordStyle = { italic = false },
            statementStyle = { italic = false },
            typeStyle = { italic = false },
            variableStyle = { italic = false },
            transparent = false,   -- do not set background color
            dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
            terminalColors = true, -- define vim.g.terminal_color_{0,17}
            colors = {             -- add/modify theme and palette colors
                palette = {},
                theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
            },
            theme = "dragon",  -- Load "wave" theme when 'background' option is not set
            background = {     -- map the value of 'background' option to a theme
                dark = "wave", -- try "dragon" !
                light = "lotus",
            },
        },
        config = function()
            -- vim.cmd([[colorscheme kanagawa]])
        end,
    },
    { "EdenEast/nightfox.nvim" },
    { "sainnhe/everforest" },
    { "sainnhe/gruvbox-material" },
    { "sainnhe/edge" },
    { "projekt0n/github-nvim-theme" },
}
