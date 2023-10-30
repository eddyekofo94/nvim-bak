local ignore_filetypes = {
  "prompt",
  "git-conflict",
  -- "term",
  "undotree",
  "noice",
  "Trouble",
  "diffview",
  "neo-tree",
  "telescope",
  "toggleterm",
  "lazy",
  "Outline",
  "TelescopePrompt",
  "TelescopeResults",
  "TelescopePreview",
}

local opts = {
  autoresize = {
    enable = true,
    quickfixheight = 60,
  },
  signcolumn = true,
  excluded_buftypes = ignore_filetypes,
  excluded_filetypes = ignore_filetypes,
  compatible_filetrees = { "git-conflict" },
  --  INFO: 2023-09-13 - Moved to autocommands
  -- ui = {
  --     number = true,         -- Display line numbers in the focussed window only
  --     relativenumber = true, -- Display relative line numbers in the focussed window only
  --     hybridnumber = true,   -- Display hybrid line numbers in the focussed window only
  --     -- BUG: This seems to not be working
  --     winhighlight = true,   -- Auto highlighting for focussed/unfocussed windows
  --     cursorline = true,     -- Display a cursorline in the focussed window only
  -- },
}

return {
  "beauwilliams/focus.nvim",
  event = "WinEnter",
  keys = {
    {
      "<leader>vj",
      "<cmd>FocusSplitDown<cr>",
      desc = "Split Down",
    },
    {
      "<leader>ve",
      "<cmd>FocusEnable<cr>",
      desc = "Focus Enable",
    },
    {
      "<leader>vh",
      "<cmd>FocusSplitLeft<cr>",
      desc = "Split Left",
    },
    {
      "<leader>vt",
      "<cmd>FocusToggle<cr>",
      desc = "Focus Toggle",
    },
    {
      "<leader>vl",
      "<cmd>FocusSplitRight<cr>",
      desc = "Split Right",
    },
    {
      "<C-w>",
      "<cmd>FocusSplitCycle<cr>",
      desc = "Move next buffer",
    },
    {
      "<C-\\>",
      "<cmd>FocusAutoresize<cr>",
      desc = "Activate autoresise",
    },
    {
      "<leader>vk",
      "<cmd>FocusSplitUp<cr>",
      desc = "Split Right",
    },
    {
      "<leader>tn",
      "<cmd>FocusSplitNicely cmd term<cr>",
      desc = "Terminal Nicely",
    },
    {
      "<leader>vv",
      "<cmd>FocusSplitNicely<cr>",
      desc = "Split Nicely",
    },
    {
      "<leader>ww",
      "<cmd>FocusMaxOrEqual<cr>",
      desc = "Max window",
    },
    {
      "<leader>-",
      "<cmd>FocusSplitDown<CR>",
      desc = "split horizontally",
    },
    {
      "<leader>=",
      "<cmd>FocusEqualise<CR>",
      desc = "balance windows",
    },
  },
  config = function()
    require("focus").setup(opts)

    -- local ignore_filetypes = { "telescope", "harpoon" }

    local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

    vim.api.nvim_create_autocmd("WinEnter", {
      group = augroup,
      callback = function(_)
        if vim.tbl_contains(ignore_filetypes, vim.bo.buftype) then
          vim.b.focus_disable = true
        end
      end,
      desc = "Disable focus autoresize for BufType",
    })

    vim.api.nvim_create_autocmd("FileType", {
      group = augroup,
      callback = function(_)
        if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
          vim.b.focus_disable = true
        end
      end,
      desc = "Disable focus autoresize for FileType",
    })
  end,
}
