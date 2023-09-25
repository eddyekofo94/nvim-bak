-- Global
vim.opt.fillchars = {
  fold = " ",
  foldopen = "",
  foldclose = "",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
vim.cmd("set listchars=tab:→\\ ,nbsp:␣,trail:•,eol:↵,precedes:«,extends:»")
-- vim.opt.listchars = {
--   tab = "→\\ ",
--   trail = "•",
--   precedes = "«",
--   extends = "»",
--   eol = "↲",
--   nbsp = "␣",
-- }
vim.cmd([[cmap w!! w !sudo tee %]])
vim.o.foldnestmax = 4
vim.o.foldlevel = 1
vim.opt.list = true
vim.o.foldcolumn = "1"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldmethod = "expr"
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.ttyfast = true
vim.opt.showtabline = 0

vim.cmd("set wildmode=longest:full,full")
-- Use menu for command line completion
vim.o.wildmenu = true

vim.o.wildoptions = "pum"
vim.opt.updatetime = 300 --Shorter update time for good user experience
vim.opt.mouse = "a"
vim.opt.autoread = true
vim.opt.conceallevel = 0
--vim.opt.compatible = true -- INFO: look into this
vim.opt.pumheight = 10 -- Makes popup menu smaller
vim.opt.backupcopy = "yes"
vim.opt.undolevels = 1000
vim.opt.shortmess:append({ c = true, S = true })
vim.opt.showmode = false
vim.opt.hidden = true
vim.opt.splitright = true
vim.opt.swapfile = true
vim.opt.splitbelow = true
vim.opt.wrapscan = true
vim.opt.backup = false

-- Autom. save file before some action
vim.o.autowrite = true

vim.opt.writebackup = false
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Number of command-lines that are remembered
vim.o.history = 10000

vim.opt.errorbells = false
vim.opt.joinspaces = false
vim.opt.title = true
vim.o.titlestring = "%<%F%=%l/%L - nvim"
vim.opt.encoding = "UTF-8"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.clipboard = "unnamedplus"
vim.opt.laststatus = 0
vim.opt.timeoutlen = 500
vim.opt.splitkeep = "screen"
vim.opt.startofline = true

-- Use ripgrep as grep tool
vim.o.grepprg = "rg --vimgrep --no-heading"
vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m"

-- Buffer
vim.opt.fileformat = "unix"
vim.opt.tabstop = 2
vim.opt.spelllang = "en_gb"
vim.opt.softtabstop = 2
vim.opt.swapfile = false
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.autochdir = true
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.inccommand = "split"
-- Faster scrolling
vim.o.lazyredraw = false
-- Decrease redraw time
vim.o.redrawtime = 100
-- Window
vim.opt.number = true
vim.opt.colorcolumn = "99999"
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.signcolumn = "yes"
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescroll = 6
vim.opt.undodir = vim.fn.stdpath("data") .. "undo"
vim.opt.undofile = true
vim.opt.sessionoptions = "resize,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.wrap = false
vim.cmd([[set nowrap]]) -- Display long lines as just one line

-- Bring back to the last possition
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local last_pos = vim.fn.line("'\"")
    if last_pos > 0 and last_pos <= vim.fn.line("$") then
      vim.api.nvim_win_set_cursor(0, { last_pos, 0 })
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "HighlightedyankRegion", timeout = 500 })
  end,
})

local function status_line()
  local mode = "%-5{%v:lua.string.upper(v:lua.vim.fn.mode())%}"
  local file_name = "%-.16t"
  local buf_nr = "[%n]"
  local modified = " %-m"
  local file_type = " %y"
  local right_align = "%="
  local line_no = "%10([%l/%L%)]"
  local pct_thru_file = "%5p%%"

  return string.format(
    "%s%s%s%s%s%s%s%s",
    mode,
    file_name,
    buf_nr,
    modified,
    file_type,
    right_align,
    line_no,
    pct_thru_file
  )
end

-- vim.opt.statusline = status_line()
-- vim.opt.winbar = status_line()

vim.cmd([[highlight HighlightedyankRegion cterm=reverse gui=reverse guifg=reverse guibg=reverse]])
vim.cmd([[set guicursor+=i-ci:ver30-Cursor-blinkwait300-blinkon200-blinkoff150]])
vim.cmd([[set guicursor+=n-v-c:blinkon10]])
vim.cmd([[
 " Proper search
 set gdefault
 set path+=**
 autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
]])
