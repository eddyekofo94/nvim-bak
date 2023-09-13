local f = require("luasnip").function_node
local M = {}

local comment_open = {
	lua = "-- ",
	typescript = "// ",
	javascript = "// ",
	scss = "// ",
	cpp = "// ",
	sh = "# ",
	fish = "# ",
	html = "<!-- ",
	query = "; ",
}

local comment_close = {
	html = " -->",
}

M.comment_open = function()
	local ft = vim.bo.filetype
	local ext = vim.fn.expand("%:e")
	if comment_open[ft] then
		return comment_open[ft]
	end
	if ft == "query" and ext == "scm" then
		return "; "
	end
end

M.comment_close = function()
	local ft = vim.bo.filetype
	if comment_close[ft] then
		return comment_close[ft]
	end
end

M.today = function()
	return os.date("%Y-%m-%d")
end

M.time = function()
	-- code
	return os.date("%H:%M")
end


M.capitalize = function(node_index)
	return f(function(args)
		local str = args[1][1]
		return str:sub(1, 1):upper() .. str:sub(2)
	end, node_index)
end

M.lower = function(node_index)
	return f(function(args)
		local str = args[1][1]
		return str:sub(1, 1):lower() .. str:sub(2)
	end, node_index)
end

M.lua_require = function(arg)
	local parts = vim.split(arg[1][1], ".", { plain = true })
	return parts[#parts] or ""
end

M.same_node = function(arg)
	return f(function(args)
		return args[1]
	end, arg)
end

M.nest_method_args = function(_, snip, _)
	local ts_query = "(required_parameter pattern: (identifier) @param )"
	local method_args = ""
	local pos_begin = snip.nodes[3].mark:pos_begin()
	local pos_end = snip.nodes[3].mark:pos_end()
	local parser = vim.treesitter.get_parser(0, "typescript")
	local tstree = parser:parse()[1]
	local node = tstree:root():named_descendant_for_range(pos_begin[1], pos_begin[2], pos_end[1],
		pos_end[2])

	if node == nil then
		return ""
	end
	for child in node:iter_children() do
		local query = vim.treesitter.query.parse("typescript", ts_query)
		---@diagnostic disable-next-line: missing-parameter
		for _, arg in query:iter_captures(child, 0) do
			method_args = method_args .. vim.treesitter.get_node_text(arg, 0) .. ", "
		end
	end

	if method_args ~= "" then
		method_args = method_args:sub(1, -3)
	end
	return method_args
end

M.nest_classname = function()
	local ts_query = "(class_declaration name: (type_identifier) @class_name)"
	local parser = vim.treesitter.get_parser(0, "typescript")
	local tstree = parser:parse()[1]
	local node = tstree:root()
	local query = vim.treesitter.query.parse("typescript", ts_query)
	---@diagnostic disable-next-line: missing-parameter
	for _, class_name in query:iter_captures(node, 0) do
		return vim.treesitter.get_node_text(class_name, 0)
	end
end

return M
