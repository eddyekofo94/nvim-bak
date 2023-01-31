local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.mapleaderlocal = " "

require("lazy").setup({
    {"nathom/filetype.nvim"},
    { "neovim/nvim-lspconfig" },
    { "folke/lsp-trouble.nvim" },
    { "folke/twilight.nvim" },
    { "folke/neodev.nvim" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "simrat39/symbols-outline.nvim" },
    { "onsails/lspkind-nvim" },
    { "folke/lsp-colors.nvim" }, -- improves the lsp warning colours TODO: ensure it works,
    { "nvim-lua/lsp_extensions.nvim" },
    { "mfussenegger/nvim-jdtls" },

    { "RishabhRD/popfix" },
    { "RishabhRD/nvim-lsputils" },

    { "sbdchd/neoformat" },

    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim", version = "0.1.1" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-project.nvim" },
    { "nvim-telescope/telescope-frecency.nvim" },
    { "jvgrootveld/telescope-zoxide" },
    { "nvim-telescope/telescope-media-files.nvim" },
    { "tami5/sql.nvim" },

    { "mfussenegger/nvim-dap" },
    { "rcarriga/nvim-dap-ui" },

    -- Auto Completion
    {
        { "L3MON4D3/LuaSnip" },

        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-nvim-lua",
            },
        },
    },

    { "rafamadriz/friendly-snippets" },

    { "blankname/vim-fish" },

    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-treesitter/nvim-treesitter-textobjects" },

    { "windwp/nvim-ts-autotag" },

    { "kyazdani42/nvim-tree.lua" },
    { "airblade/vim-rooter" },
    { "akinsho/bufferline.nvim", version = "v3.*", dependencies = "nvim-tree/nvim-web-devicons" },

    --{"lukas-reineke/indent-blankline.nvim"},

    { "lewis6991/gitsigns.nvim" },
    { "kdheepak/lazygit.nvim" },
    { "sindrets/diffview.nvim" },
    { "folke/which-key.nvim" },
    { "ChristianChiarulli/dashboard-nvim" },
    { "windwp/nvim-autopairs", dependencies = {
        "nvim-cmp",
    } },
    { "terrortylor/nvim-comment" },
    { "folke/todo-comments.nvim" },
    { "godlygeek/tabular" },
    { "mbbill/undotree" },
    {
        { "ur4ltz/surround.nvim" },
        config = function()
            require("surround").setup({ mappings_style = "surround" })
        end,
    },
    { "norcalli/nvim-colorizer.lua" },

    -- Window Toggle
    { "szw/vim-maximizer" },

    -- smooth scrolling in neovim
    { "karb94/neoscroll.nvim" },

    -- better session management in neovim
    { "rmagatti/auto-session" },
    { "rmagatti/session-lens" }, -- INFO: must be available at load time

    { "folke/zen-mode.nvim" },
    -- show lsp hover docs automatically
    { "ray-x/lsp_signature.nvim" },

    -- Color
    --  "eddyekofo94/gruvbox-flat.nvim", branch = "local" })
    --  "navarasu/onedark.nvim" })
    { "sainnhe/everforest" },

    -- Icons
    { "kyazdani42/nvim-web-devicons" },

    { "feline-nvim/feline.nvim" },
})
-- Initialise eveything from here

--require("impatient")
--require("packer_compiled")
require("eekofo")
