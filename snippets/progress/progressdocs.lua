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

-- Returns table containing insert node with provided options
local get_options = function(arg)
	local x = {}

	for key, _ in pairs(arg) do
		table.insert(x, i(1, arg[key]))
	end
	return x
end

local get_virt_text = function(choices)
	return "Choices: " .. table.concat(choices, " / ")
end
-- }}}

return {
	s({
		trig = "doc",
		snippetType = "autosnippet"
	}, {
		t({ "/***************************************", "" }),
		t({ " * " }),
		i(0,"Comment Here"),
		t({ "", " **************************************/" }),
	})
}
