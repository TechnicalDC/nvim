local starter = require('mini.starter')
local autocmd = vim.api.nvim_create_autocmd
local map     = vim.keymap.set
local opts    = { buffer = true }
local headers = require("dc.headers")

starter.setup({
	header = headers.mini,
	footer = "",
	items = {
		{ name = 'find files', action = 'Telescope find_files', section = 'Files' },
		{ name = 'browse files', action = 'lua require("mini.files").open(vim.uv.cwd(), true)', section = 'Files' },
		{ name = 'create new file', action = 'enew', section = 'Builtin actions' },
		{ name = 'quit neovim', action = 'qall', section = 'Builtin actions' },
		starter.sections.recent_files(5, true, true),
		starter.sections.recent_files(5, false, true),
		starter.sections.sessions(5, true),
	},
	content_hooks = {
		starter.gen_hook.indexing('all', { 'Builtin actions', 'Files' }),
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
map("n", "<leader>bw", _G.my_bufwipeout, { desc = "Wipeout buffer" })
