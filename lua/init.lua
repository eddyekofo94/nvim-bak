-- require("eekofo.settings")
-- require("eekofo.colorscheme")
-- require("eekofo.install-plugins")
-- require("eekofo.plugins")
-- require("eekofo.lsp")
-- require("eekofo.utils")
-- require("eekofo.autocommands")
-- require("eekofo.keymappings")
-- require("eekofo.debuger")
local cfg = require("plugin_configs")

return {
    {
        "nvim-telescope/telescope.nvim",
        module = "telescope",
        dependencies = {
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
            { "kyazdani42/nvim-web-devicons" },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
            },
        },
        config = cfg.telescope,
    },
    {
        "folke/which-key.nvim",
        config = cfg.which_key
    },
}
