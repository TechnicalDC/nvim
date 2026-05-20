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
local fmta = require("luasnip.extras.fmt").fmta
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

