vim.cmd("set iskeyword+=-") -- treat dash separated words as a word text object"
vim.o.list = true
vim.cmd("set shortmess+=c") -- Don't pass messages to |ins-completion-menu|.
vim.cmd("set inccommand=split") -- Make substitution work in realtime
vim.o.title = true
TERMINAL = vim.fn.expand("$TERMINAL")
vim.cmd('let &titleold="' .. TERMINAL .. '"')
vim.o.titlestring = "%<%F%=%l/%L - nvim"
vim.cmd("set whichwrap+=<,>,[,],h,l") -- move to next line with theses keys
vim.cmd("syntax on") -- move to next line with theses keys
vim.o.pumheight = 10 -- Makes popup menu smaller
vim.o.fileencoding = "utf-8" -- The encoding written to file
vim.o.cmdheight = 2 -- More space for displaying messages
vim.cmd("set colorcolumn=99999") -- fix indentline for now
vim.o.mouse = "a" -- Enable your mouse
vim.o.termguicolors = true -- set term giu colors most terminals support this
vim.o.splitright = true -- Vertical splits will automatically be to the right
vim.o.splitbelow = true -- Horizontal splits will automatically be below
vim.go.t_Co = "256" -- Support 256 colors
vim.o.conceallevel = 0 -- So that I can see `` in markdown files
vim.cmd("set ts=4") -- Insert 2 spaces for a tab
vim.cmd("set sw=4") -- Change the number of space characters inserted for indentation
vim.cmd("set shiftround")
-- vim.bo.expandtab = true -- Converts tabs to spaces TODO: change it back if possible
vim.bo.smartindent = true -- Makes indenting smart
vim.cmd("set backspace=indent,eol,start")
vim.cmd("set scrolloff=8") -- " start scholling when you're near the bottom by 8
vim.cmd("set sidescrolloff=6")
vim.wo.cursorline = true -- Enable highlighting of the current line
vim.o.showtabline = 0 -- Always show tabs
vim.o.showmode = false -- We don't need to see things like -- INSERT -- anymore
vim.o.backup = false -- This is recommended by coc
vim.o.writebackup = false -- This is recommended by coc
vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.o.updatetime = 300 -- Faster completion
vim.o.timeoutlen = 100 -- By default timeoutlen is 1000 ms
vim.cmd("set background=dark")
vim.opt.sessionoptions = "resize,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.o.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.cmd("set listchars=tab:→\\ ,nbsp:␣,trail:•,eol:↵,precedes:«,extends:»")
-- vim.o.guifont = "Hack Nerd Font Mono:h18"
-- vim.o.guifont = "FiraCode Nerd Font:h18"
-- vim.o.guifont = "UbuntuMono Nerd Font:h17"
-- vim.o.guifont = "Delugia:h17"
-- Disable Builtins
local builtins = {
  "gzip",
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "logiPat",
  "matchit",
  "matchparen",
  "netrw",
  "netrwFileHandlers",
  "netrwPlugin",
  "netrwSettings",
  "rrhelper",
  "tar",
  "tarPlugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in ipairs(builtins) do
  vim.g["loaded_" .. plugin] = 1
end
