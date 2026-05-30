local starter = require('mini.starter')
local autocmd = vim.api.nvim_create_autocmd
local map     = vim.keymap.set
local opts    = { buffer = true }
local headers = require("dc.headers")

local content_type_width = function(content, section_type)
	local coords = starter.content_coords(content, section_type)
	local width = math.max(unpack(vim.tbl_map(function(c)
		local line = content[c.line][c.unit].string
		return vim.fn.strdisplaywidth(line)
	end, coords)))
	return width
end

starter.setup({
	header = headers.dc,
	footer = headers.greeter,
	items = {
		{ name = 'find files', action = 'Telescope find_files', section = 'Section' },
		{ name = 'browse files', action = 'lua require("mini.files").open(vim.uv.cwd(), true)', section = 'Section' },
		{ name = 'new file', action = 'enew', section = 'Builtin actions' },
		{ name = 'quit', action = 'qall', section = 'Builtin actions' },
		-- starter.sections.recent_files(5, false, true),
		starter.sections.recent_files(5, true, true),
		starter.sections.sessions(5, true),
	},
	content_hooks = {
		-- starter.gen_hook.adding_bullet(),
		starter.gen_hook.indexing('all', { 'Builtin actions', 'Section' }),
		-- function(content)
		-- 	-- Coords
		-- 	local header_width = content_type_width(content, "header")
		-- 	local section_width = content_type_width(content, "section")
		-- 	local item_width = content_type_width(content, "item")
		-- 	local footer_width = content_type_width(content, "footer")
		-- 	local max_width = math.max(header_width, section_width, item_width, footer_width)
		--
		-- 	for _, line in ipairs(content) do
		-- 		if not (#line == 0 or (#line == 1 and line[1].string == "")) then
		-- 			local line_str = ""
		-- 			local line_types = {}
		-- 			for _, unit in ipairs(line) do
		-- 				line_str = line_str .. unit.string
		-- 				table.insert(line_types, unit.type)
		-- 			end
		-- 			local line_width = 0
		-- 			for _, type in ipairs(line_types) do
		-- 				if type == "item" or type == "section" then
		-- 					line_width = math.max(item_width, section_width)
		-- 				elseif type == "header" then
		-- 					line_width = header_width
		-- 				elseif type == "footer" then
		-- 					line_width = footer_width
		-- 				end
		-- 			end
		-- 			local left_pad = string.rep(" ", (max_width - line_width) * 0.5)
		--
		-- 			table.insert(line, 1, { string = left_pad, type = "empty" })
		-- 		end
		-- 	end
		-- 	return content
		-- end,
		starter.gen_hook.aligning('center', 'center'),
	},
	query_updaters = [[abcdefghilmoqrstuvwxyz0123456789_-,.ABCDEFGHIJKLMOQRSTUVWXYZ]],
})

autocmd("User",{
	pattern = "MiniStarterOpened",
	callback = function()
		map("n", "j", "<Cmd>lua MiniStarter.update_current_item('next')<CR>", opts)
		map("n", "k", "<Cmd>lua MiniStarter.update_current_item('prev')<CR>", opts)
	end
})

local open_starter_if_empty_buffer = function()
	local buf_id = vim.api.nvim_get_current_buf()
	local is_empty = vim.api.nvim_buf_get_name(buf_id) == "" and vim.bo[buf_id].filetype == ''
	if not is_empty then return end

	require('mini.starter').open()
	vim.api.nvim_buf_delete(buf_id, { force = true })
end

_G.my_bufdelete = function()
	require('mini.bufremove').delete()
	open_starter_if_empty_buffer()
end

_G.my_bufwipeout = function()
	require('mini.bufremove').wipeout()
	open_starter_if_empty_buffer()
end

map("n", "<leader>bd", _G.my_bufdelete, { desc = "Delete buffer" })
