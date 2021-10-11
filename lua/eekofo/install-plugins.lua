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

return require("packer").startup(function(use)
    -- Packer can manage itself as an optional plugin
    use("wbthomason/packer.nvim")

    -- TODO refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
    use({ "neovim/nvim-lspconfig", opt = true })
    use({ "glepnir/lspsaga.nvim", opt = true })
    use({ "kabouzeid/nvim-lspinstall", opt = true })
    use({ "folke/lsp-trouble.nvim", opt = true })
    use({ "simrat39/symbols-outline.nvim", opt = true })
    use({ "tjdevries/nlua.nvim", opt = true })
    use({ "onsails/lspkind-nvim", opt = true })
    use({ "folke/lsp-colors.nvim", opt = true }) -- improves the lsp warning colours TODO: ensure it works
    use({ "nvim-lua/lsp_extensions.nvim", opt = true })
    -- use({ "wbthomason/lsp-status.nvim", opt = true })
    use("RishabhRD/popfix")
    use({ "RishabhRD/nvim-lsputils", opt = true })

    -- " Formatter
    use({ "sbdchd/neoformat", opt = true })

    -- Telescope
    use({ "nvim-lua/popup.nvim", opt = true })
    use({ "nvim-lua/plenary.nvim" })
    use({ "nvim-telescope/telescope.nvim" })
    use({ "nvim-telescope/telescope-fzf-writer.nvim", opt = true })
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

    -- use("hrsh7th/cmp-nvim-lsp")
    use({ "hrsh7th/nvim-compe" })
    -- use("hrsh7th/cmp-buffer")
    use("L3MON4D3/LuaSnip")
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

    -- use({ "honza/vim-snippets", opt = true })

    use({ "blankname/vim-fish", opt = true })

    -- Treesitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use({ "windwp/nvim-ts-autotag", opt = true })

    -- Explorer
    use({ "kyazdani42/nvim-tree.lua", opt = true })
    use({ "airblade/vim-rooter", opt = true })

    use({ "lukas-reineke/indent-blankline.nvim", opt = true })

    use({ "lewis6991/gitsigns.nvim", opt = true })
    use({ "kdheepak/lazygit.nvim", opt = true })
    use({ "sindrets/diffview.nvim", opt = true })
    use({ "folke/which-key.nvim", opt = true })
    use({ "ChristianChiarulli/dashboard-nvim", opt = true })
    use({ "windwp/nvim-autopairs", after = "nvim-cmp", opt = true })
    use({ "terrortylor/nvim-comment", opt = true })
    use({ "folke/todo-comments.nvim", opt = true })
    use({ "kevinhwang91/nvim-bqf", opt = true })
    use({ "tjdevries/astronauta.nvim" })
    use({ "godlygeek/tabular", opt = true })
    use({ "mbbill/undotree" })

    -- TODO: not working
    use({ "tpope/vim-surround", opt = true })
    use({ "blackCauldron7/surround.nvim", opt = true }) -- TODO: ensure it works

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
    use({ "ray-x/lsp_signature.nvim" })

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

    use({ "numtostr/FTerm.nvim", opt = true })

    use({ "dstein64/vim-startuptime" })

    -- Color
    use({ "eddyekofo94/gruvbox-flat.nvim", branch = "local" })
    use({ "eddyekofo94/bogster.nvim" })
    -- use("monsonjeremy/onedark.nvim")
    use({ "ful1e5/onedark.nvim" })
    -- use({
    --     "projekt0n/circles.nvim",
    -- })
    -- Icons
    use({ "kyazdani42/nvim-web-devicons", opt = true })

    use({ "famiu/feline.nvim", opt = true })
    use({ "akinsho/nvim-bufferline.lua", opt = true })

    require_plugin("nvim-lspconfig")
    require_plugin("feline.nvim")
    require_plugin("markdown-preview.nvim")
    require_plugin("FTerm.nvim")
    require_plugin("auto-session")
    require_plugin("bullets.vim")
    require_plugin("lspsaga.nvim")
    require_plugin("vim-maximizer")
    require_plugin("nvim-lsputils")
    require_plugin("zen-mode.nvim")
    require_plugin("lsp-trouble.nvim")
    require_plugin("symbols-outline.nvim")
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
    require_plugin("telescope-fzf-writer.nvim")
    require_plugin("telescope-fzf-native.nvim")
    require_plugin("telescope-frecency.nvim")
    require_plugin("telescope-project.nvim")
    require_plugin("telescope-zoxide")
    require_plugin("telescope-media-files.nvim")
    require_plugin("nvim-dap")
    require_plugin("nvim-dap-ui")
    require_plugin("vim-rooter")
    require_plugin("nvim-compe")
    require_plugin("vim-vsnip")
    require_plugin("friendly-snippets")
    require_plugin("nvim-treesitter")
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
    require_plugin("nvim-bufferline.lua")
    require_plugin("vim-surround")
    require_plugin("surround.nvim")
    require_plugin("neoscroll.nvim")
end)
