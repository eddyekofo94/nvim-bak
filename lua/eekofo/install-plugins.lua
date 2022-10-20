local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

vim.cmd("autocmd BufWritePost install-plugins.lua PackerCompile") -- Auto compile when there are changes in plugins.lua

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute("packadd packer.nvim")
end

--- Check if a file or directory exists in this path
local function require_plugin(plugin)
    local plugin_prefix = fn.stdpath("data") .. "/site/pack/packer/opt/"

    local plugin_path = plugin_prefix .. plugin .. "/"
    --	print('test '..plugin_path)
    local ok, err, code = os.rename(plugin_path, plugin_path)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    --	print(ok, err, code)
    if ok then
        vim.cmd("packadd " .. plugin)
    end
    return ok, err, code
end

local packer = require("packer")
packer.startup({
    function(use)
        -- Packer can manage itself as an optional plugin
        vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")
        use("wbthomason/packer.nvim")

        -- TODO: refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
        use({ "neovim/nvim-lspconfig", opt = true })
        use({ "tami5/lspsaga.nvim", opt = true })
        use({ "folke/lsp-trouble.nvim", opt = true })
        use({ "folke/twilight.nvim", opt = true })
        --use({ "simrat39/symbols-outline.nvim", opt = true })
        use({ "tjdevries/nlua.nvim", opt = true })
        use({ "onsails/lspkind-nvim", opt = true })
        use({ "folke/lsp-colors.nvim", opt = true }) -- improves the lsp warning colours TODO: ensure it works
        use({ "nvim-lua/lsp_extensions.nvim", opt = true })
        -- Language based lsp
        use({ "mfussenegger/nvim-jdtls", opt = true })

        use({ "RishabhRD/popfix", opt = true })
        use({ "RishabhRD/nvim-lsputils", opt = true })

        -- " Formatter
        use({ "sbdchd/neoformat", opt = true })

        -- Telescope - Fuzzy finder
        use({ "nvim-lua/popup.nvim", opt = true })
        use({ "nvim-lua/plenary.nvim" })
        use({ "nvim-telescope/telescope.nvim", tag = "0.1.0" })
        use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true })
        use({ "nvim-telescope/telescope-project.nvim", opt = true })
        use({ "nvim-telescope/telescope-frecency.nvim", opt = true })
        use({ "jvgrootveld/telescope-zoxide", opt = true })
        use({ "nvim-telescope/telescope-media-files.nvim", opt = true })
        use("tami5/sql.nvim")

        -- Debugging
        use({ "mfussenegger/nvim-dap", opt = true })
        use({ "rcarriga/nvim-dap-ui", opt = true })
        use("famiu/nvim-reload") -- TODO: make this plugin useful someday

        -- Auto Completion
        use({ "L3MON4D3/LuaSnip", opt = true })
        use({
            "hrsh7th/nvim-cmp",
            requires = {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-nvim-lua",
            },
        })

        use({ "rafamadriz/friendly-snippets", opt = true })

        use({ "blankname/vim-fish", opt = true })

        -- Treesitter
        use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
        use({"nvim-treesitter/nvim-treesitter-textobjects", opt = true})

        use({ "windwp/nvim-ts-autotag", opt = true })

        -- Explorer
        use({ "kyazdani42/nvim-tree.lua", opt = true })
        use({ "airblade/vim-rooter", opt = true })

        -- UI stuff
        -- use({ "lukas-reineke/indent-blankline.nvim", opt = true })

        use({ "lewis6991/gitsigns.nvim", opt = true }) -- TODO: bring back after fixing bugs
        use({ "kdheepak/lazygit.nvim", opt = true })
        use({ "sindrets/diffview.nvim", opt = true })
        use({ "folke/which-key.nvim", opt = true })
        use({ "ChristianChiarulli/dashboard-nvim", opt = true })
        use({ "windwp/nvim-autopairs", after = "nvim-cmp", opt = true })
        use({ "terrortylor/nvim-comment", opt = true })
        use({ "folke/todo-comments.nvim", opt = true })
        use({ "godlygeek/tabular", opt = true })
        use({ "mbbill/undotree", opt = true })

        use({
            "ur4ltz/surround.nvim",
            config = function()
                require("surround").setup({ mappings_style = "surround" })
            end,
            opt = true,
        })

        use({ "norcalli/nvim-colorizer.lua", opt = true })

        -- Window Toggle
        use({ "szw/vim-maximizer", opt = true })

        -- smooth scrolling in neovim
        use({ "karb94/neoscroll.nvim", opt = true })

        -- better session management in neovim
        use({ "rmagatti/auto-session", opt = true })
        use({ "rmagatti/session-lens" }) -- INFO: must be available at load time

        -- centerpad, but much better (uses a floating window!!)
        use({
            "folke/zen-mode.nvim",
            config = function()
                require("zen-mode").setup({})
            end,
            opt = true,
        })

        -- show lsp hover docs automatically
        use({ "ray-x/lsp_signature.nvim", opt = true })

        use({
            "iamcco/markdown-preview.nvim",
            run = "cd app && yarn install",
            config = function()
                -- Set default browser to open in
                vim.g.mkdp_browser = ""
                -- Print the preview url in the command line output
                vim.g.mkdp_echo_preview_url = 1
                -- Start markdown preview server on port 5000
                vim.g.mkdp_port = 5000
            end,
            opt = true,
        })

        -- for automatic list bulleting when writing markdown or plaintext
        use({
            "dkarter/bullets.vim",
            opt = true,
            ft = { "markdown", "text", "latex", "tex" },
        })

        -- Performance
        use({ "dstein64/vim-startuptime", opt = true })
        use({ "lewis6991/impatient.nvim", rocks = "mpack" })
        use({ "nathom/filetype.nvim" })

        -- Color
        -- use({ "eddyekofo94/gruvbox-flat.nvim", branch = "local" })
        -- use({ "ful1e5/onedark.nvim" }) -- TODO: I like the colour of this onedark, maybe adjust this them with these colours?
        use({ "navarasu/onedark.nvim" })

        -- Icons
        use({ "kyazdani42/nvim-web-devicons", opt = true })

        use({ "feline-nvim/feline.nvim", opt = true })
        use({ "akinsho/bufferline.nvim", tag = "v3.*", opt = true })

        require_plugin("nvim-lspconfig")
        require_plugin("popfix")
        require_plugin("feline.nvim")
        require_plugin("vim-startuptime")
        require_plugin("lsp_signature.nvim")
        require_plugin("undotree")
        require_plugin("markdown-preview.nvim")
        require_plugin("twilight.nvim")
        require_plugin("FTerm.nvim")
        require_plugin("auto-session")
        require_plugin("bullets.vim")
        require_plugin("lspsaga.nvim")
        require_plugin("vim-maximizer")
        require_plugin("nvim-lsputils")
        require_plugin("zen-mode.nvim")
        require_plugin("lsp-trouble.nvim")
        --require_plugin("symbols-outline.nvim")
        require_plugin("todo-comments.nvim")
        require_plugin("neoformat")
        require_plugin("lsp_extensions.nvim")
        require_plugin("lspkind-nvim")
        require_plugin("which-key.nvim")
        require_plugin("nvim-lspinstall")
        require_plugin("lsp-colors.nvim")
        require_plugin("nvim-colorizer.lua")
        require_plugin("astronauta")
        require_plugin("nlua.nvim")
        -- require_plugin("indent-blankline.nvim")
        require_plugin("tabular")
        require_plugin("popup.nvim")
        require_plugin("plenary.nvim")
        require_plugin("telescope-fzf-native.nvim")
        require_plugin("telescope-frecency.nvim")
        require_plugin("telescope-project.nvim")
        require_plugin("telescope-zoxide")
        require_plugin("telescope-media-files.nvim")
        require_plugin("nvim-dap")
        require_plugin("nvim-dap-ui")
        require_plugin("vim-rooter")
        require_plugin("vim-vsnip")
        require_plugin("LuaSnip")
        require_plugin("friendly-snippets")
        require_plugin("nvim-treesitter")
        require_plugin("nvim-treesitter-textobjects")
        require_plugin("nvim-ts-autotag")
        require_plugin("nvim-tree.lua")
        require_plugin("gitsigns.nvim")
        require_plugin("lazygit.nvim")
        require_plugin("diffview.nvim")
        require_plugin("dashboard-nvim")
        require_plugin("nvim-autopairs")
        require_plugin("nvim-comment")
        require_plugin("nvim-bqf")
        require_plugin("nvim-web-devicons")
        require_plugin("bufferline.nvim")
        require_plugin("surround.nvim")
        require_plugin("neoscroll.nvim")
        require_plugin("nvim-jdtls")
    end,
    config = {
        -- Move to lua dir so impatient.nvim can cache it
        compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
    },
})
