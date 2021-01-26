local saga = require 'lspsaga'

-- add your config value here
-- default value
-- error_sign = '',
-- warn_sign = '',
-- hint_sign = '',
-- infor_sign = '',
-- code_action_icon = ' ',
-- finder_definition_icon = '  ',
-- finder_reference_icon = '  ',
-- definition_preview_icon = '  '
-- 1: thin border | 2: rounded border | 3: thick border
-- border_style = 1

local opts = {
  error_sign = 'xxx'
}

saga.init_lsp_saga(opts)
