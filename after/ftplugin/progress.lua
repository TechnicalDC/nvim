vim.opt_local.expandtab = true
vim.opt_local.tabstop = 3
vim.opt_local.shiftwidth = 3
vim.opt_local.softtabstop = 3
vim.opt_local.undofile = true
vim.opt_local.commentstring="/* %s */"
vim.opt_local.listchars = "eol:󰌑"
				 .. ",tab:  "
				 .. ",leadtab:┊ "
				 .. ",nbsp:␣"
				 .. ",lead:·"
				 .. ",leadmultispace:·"
				 .. ",trail:·"
				 .. ",space:·"
				 .. ",extends:>"
				 .. ",precedes:<"

local keywords = [[
def define as extent if then else end do elseif endif message absolute and or
assign available recid can-do can-find case when create day class month year
datetime procedure function forward returns temp-table for each delete in empty
find handle first last length modulo not now today output stream index rindex
replace round string rowid sqrt substring trim tran leave input release return
num-entries subst no-undo disp with down frame to param parameter entry put close
run label no-box width where no-lock skip column inherits unformatted by buffer
group view-as alert-box field init query next on-error avail begins no-error
implements retry undo error-status file-info input-output buffer-copy decimals
table otherwise truncate ambiguous browse pause before-hide value export import
from repeat like to-rowid substr unique primary overlay return-value on error min
max stop transaction is form stream-io column-label bind by-reference
reference-only append using exclusive-lock chr terminal next-value current-value
valid-handle lastkey row update upper lower throw catch centered help side-labels
title prompt center scrolling hide clear all choose no-pause page-up page-down home
go-on color cursor-left cursor-right cursor-up cursor-down normal next-prompt prev
frame-line while except keyfunc random handle-type no-label page-number if-first
if-last delimiter search time r-index etime persistent table-handle of
default-buffer-handle finally prepare-temp-table lookup add-new-index add-new-field
break question yes-no yes-no-cancel buttons quoter view object this-procedure
persistent through set descending os-dir case-sensitive first-of last-of colon
os-command silent display method public private protected interface override
constructor destructor new get initial this-object
]]

local types = [[
char character int integer format var variable log logical handle property yes no
true false date dec decimal buffer dataset void dataset-handle
]]

local operators = [[
and begins eq ge gt le lt matches modulo ne not or xor between contains
]]

local methods = [[
valid-object empty-dataset get-buffer-handle get-first query-prepare query-close
set-buffers query-open copy-dataset buffer-create buffer-field buffer-release get-next
]]

local properties = [[query-off-end buffer-value]]

local function words(source)
	local result = {}
	for word in source:gmatch("%S+") do
		result[#result + 1] = word
	end
	return result
end

local keyword_list = words(keywords)
local type_list = words(types)
local operator_list = words(operators)
local method_list = words(methods)
local property_list = words(properties)

local function escape_pattern(value)
	return (value:gsub("([^%w])", "%%%1"))
end

local function syntax_match(group, list)
	if #list == 0 then
		return
	end

	local alternatives = {}
	for _, word in ipairs(list) do
		alternatives[#alternatives + 1] = escape_pattern(word)
	end

	vim.cmd(("syntax match %s /\\<\\(%s\\)\\>/"):format(
		group,
		table.concat(alternatives, "\\|")
	))
end

-- Syntax highlighting
vim.cmd("syntax case ignore")
vim.cmd([[syntax region ablString start=/"/ skip=/~"/ end=/"/ oneline]])
vim.cmd([[syntax region ablComment start=/\/\*/ end=/\*\//]])
syntax_match("ablKeyword", keyword_list)
syntax_match("ablType", type_list)
syntax_match("ablOperator", operator_list)
syntax_match("ablMethod", method_list)
syntax_match("ablProperty", property_list)

vim.cmd([[
highlight default link ablKeyword Keyword
highlight default link ablType Type
highlight default link ablOperator Operator
highlight default link ablMethod Function
highlight default link ablProperty Identifier
highlight default link ablString String
highlight default link ablComment Comment
]])

-- Auto-capitalize known ABL words after a delimiter.
local abbreviation_set = {}
for _, list in ipairs({ keyword_list, type_list, operator_list }) do
	for _, word in ipairs(list) do
		abbreviation_set[word:lower()] = word:upper()
	end
end

local function in_code_context(buf, row, col)
	if col <= 0 then
		return true
	end

	local id = vim.fn.synID(row, col, 1)
	local name = vim.fn.synIDattr(vim.fn.synIDtrans(id), "name")
	return name ~= "String"
	and name ~= "Comment"
	and name ~= "ablString"
	and name ~= "ablComment"
end

local autocaps_group = vim.api.nvim_create_augroup(
	"ABLAutoCaps_" .. vim.api.nvim_get_current_buf(),
	{ clear = true }
)

vim.api.nvim_create_autocmd("InsertCharPre", {
	group = autocaps_group,
	buffer = 0,
	callback = function()
		local char = vim.v.char
		if char:match("[%w_%-]") then
			return
		end

		local cursor = vim.api.nvim_win_get_cursor(0)
		local row, col = cursor[1], cursor[2]
		local buf = vim.api.nvim_get_current_buf()

		if col == 0 or not in_code_context(buf, row, col) then
			return
		end

		local line = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)[1] or ""
		local token = line:sub(1, col):match("([%w_%-]+)$")
		if not token then
			return
		end

		local replacement = abbreviation_set[token:lower()]
		if not replacement then
			return
		end

		vim.api.nvim_buf_set_text(buf, row - 1, col - #token, row - 1, col, { replacement })
	end,
})

-- Procedure / function / method navigation.
local function is_definition(line)
	line = line:lower()
	return line:match("^%s*method%s") ~= nil
	or line:match("^%s*function%s") ~= nil
	or line:match("^%s*procedure%s") ~= nil
end

local function find_definition_line(buf, start_row, direction)
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
	local row = start_row

	while row >= 1 and row <= #lines do
		if is_definition(lines[row]) then
			return row
		end
		row = row + direction
	end

	return nil
end

local function forward_procedure()
	local buf = vim.api.nvim_get_current_buf()
	local row = vim.api.nvim_win_get_cursor(0)[1]
	local target = find_definition_line(buf, row + 1, 1)

	if target then
		vim.api.nvim_win_set_cursor(0, { target, 0 })
	else
		vim.notify("No later ABL definition found", vim.log.levels.INFO)
	end
end

local function backward_procedure()
	local buf = vim.api.nvim_get_current_buf()
	local row = vim.api.nvim_win_get_cursor(0)[1]
	local target = find_definition_line(buf, row - 1, -1)

	if target then
		vim.api.nvim_win_set_cursor(0, { target, 0 })
	else
		vim.notify("No earlier ABL definition found", vim.log.levels.INFO)
	end
end

local function occurrences()
	local buf = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
	local items = {}

	for row, line in ipairs(lines) do
		local lower = line:lower()
		if is_definition(line) or lower:match("^%s*proc%f[%W]") then
			items[#items + 1] = {
				bufnr = buf,
				lnum = row,
				col = 1,
				text = line:gsub("^%s+", ""),
			}
		end
	end

	vim.fn.setqflist({}, " ", {
		title = "ABL methods/functions/procedures",
		items = items,
	})
	vim.cmd("copen")
end

-- Decrease indentation by one ABL indentation unit.
local function backtab()
	local row = vim.api.nvim_win_get_cursor(0)[1]
	local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""

	if line:sub(1, 3) == "   " then
		vim.api.nvim_buf_set_text(0, row - 1, 0, row - 1, 3, { "" })
	end
end

-- Prefix field references with a table/buffer name.
local function assign_prefix(table_name)
	table_name = table_name or vim.fn.input("Table name: ")
	if table_name == "" then
		return
	end

	local buf = vim.api.nvim_get_current_buf()
	local row = vim.api.nvim_win_get_cursor(0)[1]
	local lines = vim.api.nvim_buf_get_lines(buf, row - 1, -1, false)
	local replacements = {}
	local started = false

	for _, line in ipairs(lines) do
		if line:match("^%s*$") then
			replacements[#replacements + 1] = line
		else
			started = true
			local indent, rest = line:match("^(%s*)(.*)$")
			local token = rest:match("^([%w_%-]+)")

			if token and not token:find("%.") then
				rest = table_name .. "." .. rest
			end

			replacements[#replacements + 1] = indent .. rest
			if rest:match("%.[%s]*$") then
				break
			end
		end
	end

	if started then
		vim.api.nvim_buf_set_lines(buf, row - 1, row - 1 + #replacements, false, replacements)
	end
end

-- Insert the test procedure template.
local function insert_test_procedure(name)
	name = name or vim.fn.input("Test procedure name: ")
	if name == "" then
		return
	end

	local lines = {
		"procedure test_" .. name .. ":",
		"    def output param p_pass as log no-undo.",
		"    def output param p_msg as char no-undo.",
		"",
		"end.",
	}

	vim.api.nvim_put(lines, "l", true, true)
end

-- Buffer-local mappings.
local map_opts = { buffer = true, silent = true }

vim.keymap.set("n", "]]", forward_procedure, vim.tbl_extend("force", map_opts, {
	desc = "Next ABL procedure/function/method",
}))
vim.keymap.set("n", "[[", backward_procedure, vim.tbl_extend("force", map_opts, {
	desc = "Previous ABL procedure/function/method",
}))
vim.keymap.set("n", "<leader>ao", occurrences, vim.tbl_extend("force", map_opts, {
	desc = "List ABL definitions",
}))
vim.keymap.set("n", "<leader>at", insert_test_procedure, vim.tbl_extend("force", map_opts, {
	desc = "Insert ABL test procedure",
}))
vim.keymap.set("i", "<S-Tab>", backtab, vim.tbl_extend("force", map_opts, {
	desc = "Decrease ABL indent",
}))

-- Buffer-local commands avoid duplicate command errors across ABL buffers.
vim.api.nvim_buf_create_user_command(0, "ABLAssignPrefix", function(args)
	assign_prefix(args.args ~= "" and args.args or nil)
end, { nargs = "?", desc = "Prefix ABL fields with a table name" })

vim.api.nvim_buf_create_user_command(0, "ABLTestProcedure", function(args)
	insert_test_procedure(args.args ~= "" and args.args or nil)
end, { nargs = "?", desc = "Insert an ABL test procedure" })
