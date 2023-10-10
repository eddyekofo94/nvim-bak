local mocha = require("utils.mocha")
local fn = vim.fn

O = {
  auto_close_tree = 0,
  auto_complete = true,
  colorscheme = "gruvbox-material",
  hidden_files = true,
  wrap_lines = false,
  number = true,
  relative_number = true,
  shell = "fish",
  -- @usage pass a table with your desired languages

  treesitter = {
    ensure_installed = "maintained",
    ignore_install = { "haskell" },
    highlight = { enabled = true },
    playground = { enabled = false },
    rainbow = { enabled = false },
  },
  python = {
    linter = "",
    -- @usage can be 'yapf', 'black'
    formatter = "",
    autoformat = false,
    isort = false,
    diagnostics = { virtual_text = true, signs = true, underline = true },
  },
  lua = {
    -- @usage can be 'lua-format'
    formatter = "",
    autoformat = false,
    diagnostics = { virtual_text = true, signs = true, underline = true },
  },
  sh = {
    -- @usage can be 'shellcheck'
    linter = "",
    -- @usage can be 'shfmt'
    formatter = "",
    autoformat = false,
    diagnostics = { virtual_text = true, signs = true, underline = true },
  },
  json = {
    -- @usage can be 'prettier'
    formatter = "",
    autoformat = false,
    diagnostics = { virtual_text = true, signs = true, underline = true },
  },
  tailwindls = {
    filetypes = {
      "html",
      "css",
      "scss",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
  },
  clang = {
    diagnostics = { virtual_text = true, signs = true, underline = true },
  },
  ruby = {
    diagnostics = { virtualtext = true, signs = true, underline = true },
    filetypes = { "rb", "erb", "rakefile" },
  },
  large_file = {
    get_file_size = function()
      return fn.getfsize(fn.expand("%")) > 512 * 1024
    end,
  },
  catppuccin_colors = mocha,
  icons = {

    mode_icon = "",
    dir = "󰉖",
    modified = "󰈙",
    lsp = {
      erver = "󰅡",
      error = "",
      warning = "",
      info = "",
      hint = "",
    },
    git = {
      branch = "",
      added = "",
      changed = "",
      removed = "",
    },
  },
  kind_icons = {
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
  },
}

DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")

P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, "plenary") then
  RELOAD = require("plenary.reload").reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end
