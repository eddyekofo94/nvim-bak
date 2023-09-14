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
-- vim.o.timeoutlen=1000
vim.cmd([[cmap w!! w !sudo tee %]])
vim.o.foldnestmax = 4
vim.o.foldlevel = 1
vim.opt.list=true
vim.o.foldcolumn = "1"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldmethod = "expr"
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.ttyfast = true
vim.opt.showtabline = 0
vim.cmd("set wildmode=longest:full,full")
vim.cmd("set wildmenu")
vim.cmd("set wildoptions=pum")
vim.opt.updatetime = 300 --Shorter update time for good user experience
vim.opt.mouse = 'a'
vim.opt.autoread = true
vim.opt.conceallevel = 0
--vim.opt.compatible = true -- INFO: look into this
vim.opt.pumheight = 10 -- Makes popup menu smaller
vim.opt.backupcopy = 'yes'
vim.opt.undolevels = 1000
vim.opt.shortmess:append { c = true, S = true }
vim.opt.showmode = false
vim.opt.hidden = true
vim.opt.splitright = true
vim.opt.swapfile = true
vim.opt.splitbelow = true
vim.opt.wrapscan = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.errorbells = false
vim.opt.joinspaces = false
vim.opt.title = true
vim.opt.encoding = 'UTF-8'
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.clipboard = 'unnamedplus'
vim.opt.laststatus = 3
vim.opt.timeoutlen = 500
if vim.fn.has("nvim-0.9.0") == 1 then
  vim.opt.splitkeep = 'screen'
end
-- Buffer
vim.opt.fileformat = 'unix'
vim.opt.tabstop = 2
vim.opt.spelllang = 'en'
vim.opt.softtabstop = 2
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.inccommand = "split"
-- Window
vim.opt.number = true
-- vim.opt.colorcolumn = "+1"
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.signcolumn = 'yes:1'
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescroll = 6
vim.opt.undodir = "~/.config/nvim/undodir"
vim.opt.sessionoptions =
"resize,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- set nowrap                              " Display long lines as just one line

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
    vim.highlight.on_yank({ higroup = 'HighlightedyankRegion', timeout = 500 })
  end,
})

vim.cmd([[highlight HighlightedyankRegion cterm=reverse gui=reverse guifg=reverse guibg=reverse]])
vim.cmd([[set guicursor+=i-ci:ver30-Cursor-blinkwait300-blinkon200-blinkoff150]])
vim.cmd([[
 " Proper search
 set incsearch
 set gdefault
 set path+=**
 autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
]])
