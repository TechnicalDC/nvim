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
local postfix = require("luasnip.extras.postfix").postfix

local snippets, autosnippets = {}, {}

-- Returns table containing insert node with provided options
local get_options = function(arg)
	local x = {}

	for key, value in pairs(arg) do
		table.insert(x, i(1, arg[key]))
	end
	return x
end
-- }}}

-- OTHER STUFFS {{{
local services = {
	"InventoryServices",
	"BaseServices",
}
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
local defvar_fmt = fmt(
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
local defvar_snippet = s("defvar", defvar_fmt)
table.insert(snippets, defvar_snippet)
-- }}}

-- DEFINE BUFFER {{{
local defbuf_fmt = fmt(
	[[
	define buffer {} for {} no-undo.
	]],
	{
		i(1,"bufferName"),
		i(2,"tableName"),
	}
)
local defbuf_snippet = s("defbuf", defbuf_fmt)
table.insert(snippets, defbuf_snippet)
-- }}}

-- DEFINE PROPERTY {{{
local defprop_fmt = fmt(
	[[
	define {}{} property {} as {} no-undo.
	]],
	{
		c(1, get_options(access_type)),
		c(2, {
			i(1," static"),
			i(1," ")
		}),
		i(3,"propertyName"),
		i(4,"className"),
	}
)
local defprop_snippet = s("defprop", defprop_fmt)
table.insert(snippets, defprop_snippet)
-- }}}

-- DEBUG MESSAGE {{{
local msg_fmt = fmt(
	[[
	message "DUU - {} -" "{}" {} {}.
	]],
	{
		i(1, "methodName"),
		i(2, "fieldName"),
		rep(2),
		c(3, {
			i(1, "view-as alert-box"),
			i(1, "")
		})
	}
)

local msg_snippet = s("msg", msg_fmt)
table.insert(snippets, msg_snippet)
-- }}}

-- FIND SNIPPET {{{
local find_fmt = fmt(
	[[
	find first {} no-error.
	if {} then do:
		{}
	end.
	]],
	{
		i(1, "tableName"),
		d(2, function (args)
			local value = args[1][1]
			if value:sub(-2) == "DO" then
					return sn(nil, t(value .. ":Available"))
			else
				return sn(nil, t("available " .. value))
			end
		end, 1),
		i(3, "/* Add Logic Here */")
	}
)
local find_snippet = s(
	{trig = "find", regTrig = false, hidden = false},
	find_fmt
)
table.insert(snippets, find_snippet)
--}}}

-- METHOD {{{
local method_fmt = fmt(
	[[
   method {} {} {} (input incustnum as integer):

      {}
   
   end method.
	]], {
		c(1, get_options(access_type)),
		c(2, get_options(data_types)),
		i(3, "methodName"),
		d(4, function ()
			return sn(nil, i(nil, "return."))
		end, 2)
	}
)
local method_snippet = s("method", method_fmt)
table.insert(snippets, method_snippet)
-- }}}

-- LOG (POST FIX) {{{
local log_fmt = fmt(
	[[
	message "{}" {} view-as alert-box.
	]], {
		d(1, function (_, parent)
			local capture = parent.snippet.env.POSTFIX_MATCH
			return sn(nil, t(capture))
		end),
		rep(1)
	}
)
local log_postfix = postfix(".log", log_fmt)
table.insert(snippets, log_postfix)
-- }}}

return snippets, autosnippets
