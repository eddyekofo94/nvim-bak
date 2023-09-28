return {
    {
        "ThePrimeagen/harpoon",
        event = "VeryLazy",
        config = function()
            local nmap = require("utils").nmap

            local wk = require("which-key")
            local harpoon = require "harpoon"

            harpoon.setup {}

            wk.register({
                a = { require("harpoon.mark").add_file, "Harpoon add file" },
                -- H = { ":Telescope harpoon marks<cr>", "Harpoon menu" },
                -- H = { require("harpoon.ui").toggle_quick_menu, "Harpoon menu" },
            }, { prefix = "<leader>" })

            nmap { "<c-p>", require("harpoon.ui").nav_prev, "Harpoon previous file" }
            nmap { "<c-n>", require("harpoon.ui").nav_next, "Harpoon next file" }

            for i = 1, 5 do
                nmap {
                    string.format("<space>%s", i),
                    function()
                        require("harpoon.ui").nav_file(i)
                    end,
                    string.format("Harpoon get file %s", i),
                }
            end
        end,
    },
}
