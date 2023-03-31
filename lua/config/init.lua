local cfg = require("plugins")
require("autocommands")
require("keymaps")
require("plugins")
require("globals")

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            { "williamboman/mason.nvim" }, -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional
            -- Autocompletion
            { "hrsh7th/nvim-cmp" }, -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "hrsh7th/cmp-buffer" }, -- Optional
            { "hrsh7th/cmp-path" }, -- Optional
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            { "hrsh7th/cmp-nvim-lua" }, -- Optional
            {
                "onsails/lspkind-nvim",
                event = "VeryLazy",
                config = function()
                    _ = require("lspkind").init()
                end,
            },

            -- Snippets
            {
                "L3MON4D3/LuaSnip",
                dependencies = {
                    "rafamadriz/friendly-snippets",
                    config = function()
                        require("luasnip.loaders.from_vscode").lazy_load()
                    end,
                },
                opts = {
                    history = true,
                    delete_check_events = "TextChanged",
                },
            }, -- Required
            { "rafamadriz/friendly-snippets" }, -- Optional
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local kind_icons = {
                Class = " ",
                Color = " ",
                Constant = "ﲀ ",
                Constructor = " ",
                Enum = "練",
                EnumMember = " ",
                Event = " ",
                Field = " ",
                File = "",
                Folder = " ",
                Function = " ",
                Interface = "ﰮ ",
                Keyword = " ",
                Method = " ",
                Module = " ",
                Operator = "",
                Property = " ",
                Reference = " ",
                Snippet = " ",
                Struct = " ",
                Text = " ",
                TypeParameter = " ",
                Unit = "塞",
                Value = " ",
                Variable = " ",
            }

            local cmp_setup = {
                mapping = require("lsp-zero.nvim-cmp-setup").default_mappings(),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "nvim_lua" },
                    { name = "buffer" },
                    { name = "spell" },
                    { name = "treesitter" },
                    { name = "neorg" },
                    { name = "path" },
                },
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.kind = kind_icons[vim_item.kind] .. " " .. vim_item.kind
                        vim_item.menu = ({
                            nvim_lsp = "(LSP)",
                            luasnip = "(Snippet)",
                            emoji = "(Emoji)",
                            path = "(Path)",
                            calc = "(Calc)",
                            cmp_tabnine = "(Tabnine)",
                            buffer = "(Buffer)",
                        })[entry.source.name]
                        vim_item.dup = ({
                            buffer = 1,
                            path = 1,
                            nvim_lsp = 0,
                        })[entry.source.name] or 0
                        return vim_item
                    end,
                },
            }

            cmp_setup.mapping["<C-k>"] = cmp.mapping.select_prev_item()
            cmp_setup.mapping["<C-j>"] = cmp.mapping.select_next_item()

            cmp_setup.mapping["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, {
                "i",
                "s",
            })

            cmp_setup.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, {
                "i",
                "s",
            })

            local lsp = require("lsp-zero")
            lsp.preset("recommended")

            -- NOTE: Given that we want lspsaga to handle this, we omit those keymaps
            lsp.set_preferences({
                set_lsp_keymaps = { omit = { "gd", "K" } },
            })
            lsp.ensure_installed({
                "lua_ls",
                "vimls",
                "rust_analyzer",
                "yamlls",
                "pylsp",
                "dockerls",
                "clangd",
                "bashls",
                "sqlls",
                "cmake",
                "dockerls",
            })
            -- (Optional) Configure lua language server for neovim

            lsp.setup_nvim_cmp({
                mapping = cmp_setup.mapping,
                sources = cmp_setup.sources,
            })
            lsp.nvim_workspace()
            lsp.setup()

            vim.api.nvim_create_autocmd("BufWritePre", {
                callback = function()
                    local client = vim.lsp.get_active_clients()[1]
                    if not client then
                        return
                    end
                    vim.cmd([[LspZeroFormat]])
                end,
            })
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd.colorscheme("catppuccin")
            require("colorscheme")
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        event = "VeryLazy",
    },
    {
        --    better session management in neovim
        "rmagatti/auto-session",
        config = function()
            require("plugins.sessions")
        end,
    },
    {
        "folke/twilight.nvim",
        config = function()
            require("twilight").setup({})
        end,
    },
    {
        -- git signs
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("plugins.gitsigns")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
            "nvim-treesitter/nvim-treesitter-textobjects",

            "windwp/nvim-ts-autotag",
        },
        config = cfg.treesitter,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        event = "VeryLazy",
        config = function()
            require("plugins.neo-tree")
        end,
        dependencies = {

            { "s1n7ax/nvim-window-picker", version = "v1.*" },
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        },
    },
    {

        "norcalli/nvim-colorizer.lua",
        event = { "VeryLazy" },
        config = function()
            require("colorizer").setup()
        end,
    },
    {

        "karb94/neoscroll.nvim",
        event = { "VeryLazy" },
        config = function()
            require("plugins.neoscroll")
        end,
    },
    {
        "ur4ltz/surround.nvim",
        event = { "VeryLazy" },
        config = function()
            require("surround").setup({ mappings_style = "surround" })
        end,
    },
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("todo-comments").setup({})
        end,
    },
    {
        "mbbill/undotree",
    },
    {
        "airblade/vim-rooter",
    },
    {

        "terrortylor/nvim-comment",
        event = "VeryLazy",
        config = function()
            require("nvim_comment").setup()
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = { spelling = true },
        },
        config = cfg.which_key,
    },
    {
        --         -- Window Toggle
        "szw/vim-maximizer",
        event = "VeryLazy",
    },
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {

            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            {
                "nvim-telescope/telescope-project.nvim",
                config = function()
                    require("telescope").load_extension("project")
                end,
            },
            {
                "nvim-telescope/telescope-frecency.nvim",
                config = function()
                    require("telescope").load_extension("frecency")
                end,
            },
            {
                "jvgrootveld/telescope-zoxide",
                config = function()
                    require("telescope").load_extension("zoxide")
                end,
            },
            "tami5/sql.nvim",
        },
        version = false, -- telescope did only one release, so use HEAD for now
        config = function()
            cfg.telescope()
        end,
    },
    {
        "telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            config = function()
                require("telescope").load_extension("fzf")
            end,
            {

                "rmagatti/session-lens",
                config = function()
                    require("telescope").load_extension("session-lens")
                end,
            },
        },
    },
    {
        "feline-nvim/feline.nvim",
        config = function()
            require("plugins.feline")
        end,
    },
    {
        "folke/noice.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("plugins.noice")
        end,
        dependencies = {
            "rcarriga/nvim-notify",
            "MunifTanjim/nui.nvim",
        },
    },
    { "tpope/vim-surround", event = "InsertEnter" },
    { "p00f/nvim-ts-rainbow", event = "BufReadPre" },
    {
        "windwp/nvim-autopairs",
        event = "BufReadPre",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },
    {
        "glepnir/lspsaga.nvim",
        event = "VeryLazy",
        config = function()
            require("lspsaga").setup({})
        end,
        dependencies = { { "nvim-tree/nvim-web-devicons" } },
    },
    {
        "nvim-neorg/neorg",
        event = "VeryLazy",
        build = ":Neorg sync-parsers",
        opts = {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.presenter"] = {
                    config = {
                        zen_mode = "truezen",
                    },
                }, -- Adds pretty icons to your documents
                ["core.norg.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                        name = "[Neorg]",
                    },
                },
                ["core.export.markdown"] = {},
                ["core.export"] = {
                    config = {
                        export_dir = "~/notes/exports",
                    },
                },
                ["core.norg.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        },
                    },
                },
            },
        },
        dependencies = { { "nvim-lua/plenary.nvim" } },
    },
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        event = "VeryLazy",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    {
        "mhartington/formatter.nvim",
        event = "VeryLazy",
        --cmd = "Format",
        config = function()
            require("plugins.formatter")
        end,
    },
    {
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        config = function()
            require("plugins.web-devicons")
        end,
    },
    {
        "Pocco81/true-zen.nvim",
        config = function()
            require("true-zen").setup({
                integrations = {
                    lualine = true, -- hide nvim-lualine (ataraxis)
                },
            })
        end,
    },
}
