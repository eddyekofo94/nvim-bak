local telescope = require('telescope')
-- RELOAD = require('plenary.reload').reload_module

-- R = function(name)
  -- RELOAD(name)
  -- return require(name)
-- end

-- local should_reload = true
-- local reloader = function()
  -- if should_reload then
    -- RELOAD('plenary')
    -- RELOAD('popup')
    -- RELOAD('telescope')
  -- end
-- end

-- reloader()

telescope.setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_position = "top",
    prompt_prefix = "»",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_defaults = {
      -- TODO add builtin options.
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0, -- transparency
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
    grep_previewer = require'telescope.previewers'.vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
    qflist_previewer = require'telescope.previewers'.qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`
  }
}

-- local M = {}

-- function M.edit_neovim()
  -- require('telescope.builtin').find_files {
    -- prompt_title = "~ dotfiles ~",
    -- shorten_path = true,
    -- cwd = "~/.config/nvim",
    -- width = .25,

    -- layout_strategy = 'horizontal',
    -- layout_config = {
      -- preview_width = 0.65,
    -- },
  -- }
-- end


-- function M.edit_dotfiles()
  -- require('telescope.builtin').find_files {
    -- shorten_path = false,
    -- cwd = "~/.files/",
    -- prompt = "~ dot-framework ~",
    -- layout_strategy = 'horizontal',
    -- layout_config = {
      -- preview_width = 0.55,
    -- },
  -- }
-- end

-- function M.fd()
  -- require('telescope.builtin').fd()
-- end

-- function M.search_all_files()
  -- require('telescope.builtin').find_files {
    -- find_command = { 'rg', '--no-ignore', '--files', },
  -- }
-- end


-- return setmetatable({}, {
  -- __index = function(_, k)
    -- reloader()

    -- if M[k] then
      -- return M[k]
    -- else
      -- return require('telescope.builtin')[k]
    -- end
  -- end
-- })
