return {
    "akinsho/nvim-bufferline.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "BufReadPre",
    keys = {
        { "<TAB>", "[[<Cmd>BufferLineCycleNext<CR>]]", desc = "Move to next buffer" },
        { "<S-TAB>", "[[<Cmd>BufferLineCyclePrev<CR>]]", desc = "Move to previous buffer" },
    },
    opts = {
        options = {
            show_buffer_close_icons = false,
            show_close_icon = true,
            modified_icon = "",
            buffer_close_icon = "",
            persist_buffer_sort = true,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "File Explorer",
                    highlight = "Directory",
                    text_align = "left",
                },
            },
        },
    },
}
