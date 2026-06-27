local config = require("dc.config")
local icons = require("mini.icons")
local modes = setmetatable({
	['n']  = {'NORMAL',     'N',   'StatuslineMode'},
	['no'] = {'N·OPERATOR', 'N·P', 'StatuslineMode'},
	['v']  = {'VISUAL',     'V',   'StatuslineMode'},
	['V']  = {'V·LINE',     'V·L', 'StatuslineMode'},
	['']   = {'V·BLOCK',    'V·B', 'StatuslineMode'},
	[''] = {'V·BLOCK',    'V·B', 'StatuslineMode'},
	['s']  = {'SELECT',     'S',   'StatuslineMode'},
	['S']  = {'S·LINE',     'S·L', 'StatuslineMode'},
	[''] = {'S·BLOCK',    'S·B', 'StatuslineMode'},
	['i']  = {'INSERT',     'I',   'StatuslineMode'},
	['ic'] = {'INSERT',     'I',   'StatuslineMode'},
	['R']  = {'REPLACE',    'R',   'StatuslineMode'},
	['Rv'] = {'V·REPLACE',  'V·R', 'StatuslineMode'},
	['c']  = {'COMMAND',    'C',   'StatuslineMode'},
	['!']  = {'SHELL',      'S',   'StatuslineMode'},
	['t']  = {'TERMINAL',   'T',   'StatuslineMode'},
	['cv'] = {'VIM·EX',     'V·E','StatuslineMode'},
	['ce'] = {'EX',         'E',  'StatuslineMode'},
	['r']  = {'PROMPT',     'P',  'StatuslineMode'},
	['rm'] = {'MORE',       'M',  'StatuslineMode'},
	['r?'] = {'CONFIRM',    'C',  'StatuslineMode'},
}, {
	-- By default return 'Unknown' but this shouldn't be needed
	__index = function()
		return   { 'UNKNOWN',  'U', 'StatuslineMode' }
	end,
})

local exclude_statusline = function()
	if vim.tbl_contains(config.statusline.exclude_filetype, vim.bo.filetype) then
		return true
	end
	return false
end

local get_current_mode = function()
	local current_mode = vim.api.nvim_get_mode().mode
	local mode = string.format('%s', modes[current_mode][1])
	local hl = string.format('%s', modes[current_mode][3])
	return "%#" .. hl .. "# " .. mode .. " %#StatusLine#"
end

local get_pwd = function ()
	return " %#Directory#%#StatusLine# " .. vim.fn.getcwd() .. " "
end

local get_filename = function ()
	if exclude_statusline() then
		return ""
	end

	local filename = ""
	local cwd = vim.fn.getcwd()
	local home = os.getenv("HOME")
	local head = vim.fn.expand("%:.:h")
	cwd = home and cwd:gsub(home, "~") or cwd

	if head == "" then
		return " [No Name]"
	end

	local tail = vim.fn.expand("%:t")

	if vim.bo.filetype == "help" then
		return " " .. tail
	end

	if config.statusline.show_cwd then
		filename = filename .. cwd
	end

	filename = icons.get("filetype",vim.bo.filetype) .. " " .. filename .. (head == "." and "" or head .. "/") .. tail

	if vim.bo.modified then
		filename = "%#Error# " .. filename .. " %#StatusLine#"
	else
		filename = " " .. filename .. " "
	end

	return filename
end

local get_location = function ()
	if exclude_statusline() then
		return ""
	end
	return "  %-3.(%l/%L "
end

local get_diagnotics = function ()
	return vim.diagnostic.status() .. " "
end

function _G.setup_statusline()
	return table.concat {
		get_current_mode(),
		get_pwd(),
		get_filename(),
		" %<",
		"%=",
		get_diagnotics(),
		get_location(),
	}
end

vim.opt.statusline = "%{%v:lua.setup_statusline()%}"
