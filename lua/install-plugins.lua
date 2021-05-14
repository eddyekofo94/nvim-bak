local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
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

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require("packer").startup(
    function(use)
        -- Packer can manage itself as an optional plugin
        use "wbthomason/packer.nvim"

        -- TODO refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
        use {"neovim/nvim-lspconfig", opt = true}
        use {"glepnir/lspsaga.nvim", opt = true}
        use {"kabouzeid/nvim-lspinstall", opt = true}
        use {"folke/lsp-trouble.nvim", opt = true}
        use {"tjdevries/nlua.nvim", opt = true}
        use {"onsails/lspkind-nvim", opt = true}
        use {"folke/lsp-colors.nvim", opt = true} -- improves the lsp warning colours TODO: ensure it works
        use {"wbthomason/lsp-status.nvim", opt = true}
        use "RishabhRD/popfix"
        use {"RishabhRD/nvim-lsputils", opt = true}

        -- " Trying this formatter instead
        use {"sbdchd/neoformat", opt = true}

        -- Telescope
        use {"nvim-lua/popup.nvim", opt = true}
        use {"nvim-lua/plenary.nvim", opt = true}
        use {"nvim-telescope/telescope.nvim", opt = true}
        use {"nvim-telescope/telescope-fzf-writer.nvim", opt = true}
        use {"nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true}
        use {
            "nvim-telescope/telescope-frecency.nvim",
            config = function()
                require "telescope".load_extension("frecency")
            end
        }
        use "tami5/sql.nvim"

        -- Debugging
        use {"mfussenegger/nvim-dap", opt = true}

        -- Autocomplete
        use {"hrsh7th/nvim-compe", opt = true}
        use {"hrsh7th/vim-vsnip", opt = true}
        use {"rafamadriz/friendly-snippets", opt = true}
        use {"SirVer/ultisnips", opt = true}
        use {"honza/vim-snippets", opt = true}
        use {"dag/vim-fish", opt = true}

        -- Treesitter
        use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
        use {"windwp/nvim-ts-autotag", opt = true}

        -- Explorer
        use {"kyazdani42/nvim-tree.lua", opt = true}
        use {"kevinhwang91/rnvimr", opt = true}
        use {"airblade/vim-rooter", opt = true}

        -- Terminal
        use {"akinsho/nvim-toggleterm.lua", opt = true}
        use {"voldikss/vim-floaterm", opt = true}

        use {"lukas-reineke/indent-blankline.nvim", opt = true, branch = "lua"}
        use {"lewis6991/gitsigns.nvim", opt = true}
        use {"kdheepak/lazygit.nvim", opt = true}
        -- use {"liuchengxu/vim-which-key", opt = true}
        use {"folke/which-key.nvim", opt = true}
        use {"ChristianChiarulli/dashboard-nvim", opt = true}
        use {"windwp/nvim-autopairs", opt = true}
        use {"terrortylor/nvim-comment", opt = true}
        use {"folke/todo-comments.nvim", opt = true}
        use {"kevinhwang91/nvim-bqf", opt = true}
        use {"tjdevries/astronauta.nvim"}
        use {"godlygeek/tabular", opt = true}
        use {"mbbill/undotree"}

        -- TODO: not working
        use {"tpope/vim-surround", opt = true}
        use {"blackCauldron7/surround.nvim", opt = true} -- TODO: ensure it works

        use {"norcalli/nvim-colorizer.lua", opt = true}
        -- Window Toggle
        use {"szw/vim-maximizer", opt = true}

        -- Color
        use {"folke/tokyonight.nvim", opt = true}

        -- Icons
        use {"kyazdani42/nvim-web-devicons", opt = true}

        -- Status Line and Bufferline
        use {"glepnir/galaxyline.nvim", opt = true}
        use {"romgrk/barbar.nvim", opt = true}

        require_plugin("nvim-lspconfig")
        require_plugin("lspsaga.nvim")
        require_plugin("vim-maximizer")
        require_plugin("nvim-lsputils")
        require_plugin("lsp-status.nvim")
        require_plugin("lsp-trouble.nvim")
        require_plugin("todo-comments.nvim")
        require_plugin("neoformat")
        require_plugin("ultisnips")
        require_plugin("vim-floaterm")
        require_plugin("lspkind-nvim")
        require_plugin("nvim-lspinstall")
        require_plugin("rnvimr")
        require_plugin("lsp-colors.nvim")
        require_plugin("nvim-colorizer.lua")
        require_plugin("astronauta")
        require_plugin("nlua.nvim")
        require_plugin("indent-blankline.nvim")
        require_plugin("tabular")
        require_plugin("popup.nvim")
        require_plugin("plenary.nvim")
        require_plugin("telescope.nvim")
        require_plugin("telescope-fzf-writer.nvim")
        require_plugin("nvim-toggleterm.lua")
        require_plugin("telescope-fzf-native.nvim")
        require_plugin("telescope-frecency.nvim")
        require_plugin("nvim-dap")
        require_plugin("vim-rooter")
        require_plugin("nvim-compe")
        require_plugin("vim-vsnip")
        require_plugin("nvim-treesitter")
        require_plugin("nvim-ts-autotag")
        require_plugin("nvim-tree.lua")
        require_plugin("gitsigns.nvim")
        require_plugin("lazygit.nvim")
        -- require_plugin("vim-which-key")
        require_plugin("which-key.nvim")
        require_plugin("dashboard-nvim")
        require_plugin("nvim-autopairs")
        require_plugin("nvim-comment")
        require_plugin("nvim-bqf")
        require_plugin("nvim-web-devicons")
        require_plugin("galaxyline.nvim")
        require_plugin("barbar.nvim")
        require_plugin("tokyonight.nvim")
        require_plugin("vim-surround")
        require_plugin("surround.nvim")
    end
)
