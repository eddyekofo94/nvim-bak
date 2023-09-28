-- INFO: This seems to break Lazygit, we can't have that
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = "ToggleTerm",
  keys = {
    {
      "<leader>G",
      function()
        _lazygit_toggle()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>tt",
      "<cmd>ToggleTerm<cr>",
      desc = "Toggle Term",
    },
    {
      "<leader>tv",
      "<cmd>ToggleTerm direction=vertical<cr>",
      desc = "Terminal vertical",
    },
    {
      "<leader>th",
      "<cmd>ToggleTerm direction=horizontal<cr>",
      desc = "Terminal horizontal",
    },
    {
      "<A-i>",
      vim.cmd.ToggleTerm,
      mode = { "n", "t" },
      desc = "Toggle terminal",
    },
  },
  config = function()
    require("toggleterm").setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 20
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      start_in_insert = true,
      insert_mappings = true,
      direction = "float",
      close_on_exit = true,
      float_opts = {
        border = "single",
        width = 180,
        height = 90,
      },
    })
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "single",
        width = 250,
        height = 250,
      },
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
      -- function to run on closing the terminal
      on_close = function(term)
        vim.cmd("startinsert!")
      end,
    })

    function _lazygit_toggle()
      lazygit:toggle()
    end
  end,
}
