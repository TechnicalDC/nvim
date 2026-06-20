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

-- OTHER STUFFS {{{
local services = {
	"InventoryServices",
	"BaseServices",
	"QraServices",
}
local lock_type = {
	"",
	"no-lock",
	"exclusive-lock"
}
local data_types = {
	"void",
	"character",
	"decimal",
	"integer",
	"handle",
	"date",
	"logical",
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
local fetch = {
	"first",
	"each",
	"last",
	"next",
	"prev"
}
-- }}}

local function param_docs(args)
	local params_list = args[1]
	local nodes = {}

	for _, param in ipairs(params_list) do
		param = vim.trim(param)
		local param_name = vim.split(param, " ", { trimempty = true })

		if param_name[2] ~= nil then
			param = param_name[2]
		end

		table.insert(nodes, t({ " * @param " .. param, "" }))
	end

	table.insert(nodes, t({ " * " }))

	return sn(nil, nodes)
end

return {
	-- DEFINE VARIABLE {{{
	s({
		trig="-dv",
		name='define variable',
		desc='define new variable',
		snippetType = "autosnippet"
	}, fmt(
		[[
		define variable {1} {2} {3} no-undo.
		]],
		{
			d(1, function(_, snip)
				return sn(1, i(1,snip.env.TM_SELECTED_TEXT[1] or {"variableName"}))
			end),
			c(2, {
				i(1, "as"),
				i(1, "like"),
			}),
			d(3, function (args)
				local value = args[1][1]
				if value == "like" then
					return sn(nil, {
						i(1,"fieldName"),
					})
				else
					return sn(nil, {
						c(1, get_options(data_types), {
							node_ext_opts = {
								active = {
									-- override highlight here ("GruvboxOrange").
									virt_text = {{ get_virt_text(data_types) , "Comment"}}
								}
							}
						})
					})
				end
			end, 2),
		}
	)),
	-- }}}

	-- DEFINE BUFFER {{{
	s({
		trig="-db",
		name='define buffer',
		desc='define new buffer',
		snippetType = "autosnippet"
	}, fmt(
		[[
		define buffer {} for {} no-undo.
		]],
		{
			i(1,"bufferName"),
			i(2,"tableName"),
		}
	)),
	-- }}}

	-- DEFINE PROPERTY {{{
	s({
		trig="-dp",
		name='define property',
		desc='define new property',
		snippetType = "autosnippet"
	}, fmt(
		[[
		define {}{} property {} as {} no-undo
			get:
				if not valid-object({}) then
					{} = {}:{}().
					return {}.
			end get.
			set.
		]],
		{
			c(1, get_options(access_type), {
				node_ext_opts = {
					active = {
						virt_text = {{ get_virt_text(access_type) , "Comment"}}
					}
				}
			}),
			c(2, {
				i(1," static"),
				i(1," ")
			}),
			i(3,"propertyName"),
			i(4,"className"),
			rep(3),
			rep(3),
			c(5, get_options(services)),
			i(6, "GetMethodName"),
			rep(3),
		}
	)),
	-- }}}

	-- DEBUG MESSAGE {{{
	s("msg", fmt(
		[[
		message "DUU - {} - {}" {} {}.
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
	)),
	-- }}}

	-- FIND SNIPPET {{{
	s({
		trig = "-fd",
		name='find query',
		desc='create new find query',
		snippetType = "autosnippet"
	}, fmt(
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
	)),
	--}}}

	-- FOR SNIPPET {{{
	s({
		trig = "-for",
		name='for query',
		desc='create new for query',
		snippetType = "autosnippet"
	}, fmt(
		[[
		for {} {} {}:
			{}
		end.
		]],
		{
			c(1, get_options(fetch)),
			i(2, "tableName"),
			c(3, get_options(lock_type)),
			i(4, "/* Add Logic Here */")
		}
	)),
	--}}}

	-- FOR WITH WHERE CONDITION SNIPPET {{{
	s({
		trig = "-forw",
		name='for query',
		desc='create new for query with condition',
		snippetType = "autosnippet"
	}, fmt(
		[[
		for {} {} {}
			where {}:
			{}
		end.
		]],
		{
			c(1, get_options(fetch)),
			i(2, "tableName"),
			c(3, get_options(lock_type)),
			i(4, "condition"),
			i(5, "/* Add Logic Here */")
		}
	)),
	--}}}

	-- METHOD {{{
	 s({
		trig = "-met",
		name='method',
		desc='define new method',
		snippetType = "autosnippet"
	 }, fmt(
		[[
		method {} {} {} ({}):

			{}

		end method.
		]], {
			c(1, get_options(access_type)),
			c(2, get_options(data_types)),
			i(3, "methodName"),
			i(4, "arguments"),
			i(5, "/* Add logic here */")
		}
	)),
	-- }}}

	-- LOG (POST FIX) {{{
	postfix(".log",  fmt(
		[[
		message "{}" {} view-as alert-box.
		]], {
			d(1, function (_, parent)
				local capture = parent.snippet.env.POSTFIX_MATCH
				return sn(nil, t(capture))
			end),
			rep(1)
		}
	)),
	-- }}}

	-- CLASS {{{
	s({
		trig = "-class",
		name = 'class',
		desc = 'define new class',
		snippetType = "autosnippet"
	 }, fmt(
		[[
		class {}:

			{}

		end class.
		]], {
			i(1, "className"),
			i(2, "/* Add logic here */")
		}
	)),
	-- }}}

	-- DO ON ERROR {{{
	s({
		trig = "-doe",
		snippetType = "autosnippet"
	}, fmt([[
		do on error undo, throw:

			{}

			catch e as Progress.Lang.Error:

				message
				e:GetMessage(1)
				skip
				e:CallStack
				view-as alert-box error.

			end catch.
		end.
		]], {
			i(1),
		})
	),
	--}}}

	-- CALL METHOD WITH RETURN TYPE {{{
	s({
		trig = "-mr",
		snippetType = "autosnippet",
	}, fmt([[
		{} = this-object:{}({}).
		]], {
			i(1, "variable"),
			i(2, "methodName"),
			i(3, "inputs"),
		}
	)),
	-- }}}

	-- CALL SERVICE METHOD WITH RETURN TYPE {{{
	s({
		trig = "-sr",
		snippetType = "autosnippet",
	}, fmt([[
		{} = this-object:{}:{}({}).
		]], {
			i(1, "variable"),
			i(2, "service"),
			i(3, "methodName"),
			i(4, "inputs"),
		}
	)),
	-- }}}

	-- CALL METHOD {{{
	s({
		trig = "-mn",
		snippetType = "autosnippet",
	}, fmt([[
		this-object:{}({}).
		]], {
			i(1, "methodName"),
			i(2, "inputs"),
		}
	)),
	-- }}}

	-- CALL SERVICE METHOD {{{
	s({
		trig = "-sn",
		snippetType = "autosnippet",
	}, fmt([[
		this-object:{}:{}({}).
		]], {
			i(1, "service"),
			i(2, "methodName"),
			i(3, "inputs"),
		}
	)),
	-- }}}

	-- METHOD ARGUMENTS {{{
	s({
		trig = "-inp(%d+)",
		regTrig = true,
		wordTrig = false,
		snippetType = "autosnippet"
	}, {
		d(1,function(_, snip)
			local nodes = {}
			local i_counter = 0
			local total_args = tonumber(snip.captures[1])
			if total_args == nil then
				total_args = 1
			end
			for idx = 1, total_args do
				i_counter = i_counter + 1

				table.insert(nodes, c(i_counter, get_options(input_types), {
					node_ext_opts = {
						active = {
							-- override highlight here ("GruvboxOrange").
							virt_text = {{ get_virt_text(input_types) , "Comment"}}
						}
					}
				} ))
				table.insert(nodes, t(" "))

				i_counter = i_counter + 1
				table.insert(nodes, i(i_counter, "argName" .. tostring(idx)))
				table.insert(nodes, t(" as "))

				i_counter = i_counter + 1
				table.insert(nodes, c(i_counter, get_options(data_types), {
					node_ext_opts = {
						active = {
							virt_text = {{ get_virt_text(data_types) , "Comment"}}
						}
					}
				}))

				if idx < total_args then
					table.insert(nodes, t({",", ""}))
				end
			end
			return sn(nil, nodes)
		end),
	}),
	-- }}}

	-- BANNER {{{
	s({
		trig = "-banner",
		snippetType = "autosnippet"
	}, fmt([[
	/*
	 * com.qad.{1}.{2}.IConfirmTask.cls - {3}
	 *
	 * Copyright 1986 QAD Inc. All rights reserved.
	 *
	 * $Id$ 
    */
	]], {
		i(1, "appName"),
		i(2, "moduleName"),
		i(3, "description")
	})),
	-- }}}

	-- INTERFACE {{{
	s({
		trig = "-interface",
		name = 'interface',
		desc = 'define new interface',
		snippetType = "autosnippet"
	 }, fmt(
		[[
		interface {}:

			{}

		end interface.
		]], {
			i(1, "interfaceName"),
			i(2, "/* Add logic here */")
		}
	)),
	-- }}}

	s({
		trig = "-imet",
		name='method',
		desc='define new method',
		snippetType = "autosnippet"
	}, fmt(
		[[
		/*
		 * {}
		 *
		{}
		 * @external
		 *
		 * @example
		 * {}
		 */
		method {} {} {} ({}).
		]], {
			i(1, "Description"),
			d(2, param_docs, { 7 }),
			i(3, "example"),
			c(4, get_options(access_type)),
			c(5, get_options(data_types)),
			i(6, "methodName"),
			i(7, "argumentList"),
		}
	)),
}
