---@diagnostic disable: unused-local
-- REQUIRED {{{
local ls = require("luasnip")
local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

local snippets, autosnippets = {}, {}
-- }}}

-- OTHER STUFFS {{{
local lock_type = {
	"no-lock",
	"",
	"exclusive-lock"
}
local def_types = {
	"variable",
	"frame",
   "property",
	"query",
	"buffer",
	"stream",
	"input parameter",
	"output parameter",
	"temp-table"
}
local data_types = {
	"character",
	"decimal",
	"integer",
	"handle",
	"date",
	"logical",
	"void"
}
local access_type = {
	"public",
	"private",
	"protected"
}
local input_types = {
	"input",
	"output",
	"input-output",
}
-- }}}

-- DEFINE VARIABLE {{{
local def_fmt = fmt(
	[[
	define variable {} {} {} no-undo.
	]],
	{
		d(1, function(_, snip)
			return sn(1, i(1,snip.env.TM_SELECTED_TEXT[1] or {"<++>"}))
		end),
		c(2, {
			i(1, "as character"),
			i(1, "as integer"),
			i(1, "as decimal"),
			i(1, "as date"),
			i(1, "as logical"),
			i(1, "like"),
		}),
		d(3, function (args)
			local value = args[1][1]
			if value == "like" then
			return sn(nil, {
				i("Hello"),
			})
			else
			return sn(nil, {
				t(""),
			})
			end
		end, 2),
	}
)
local def_snippet = s("define", def_fmt)
table.insert(snippets, def_snippet)
-- }}}

return snippets, autosnippets
