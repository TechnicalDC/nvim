return {
	'saghen/blink.cmp',
	dependencies = {
		'LMON4D3/LuaSnip',
	},
	version = 'v0.*',
	opts = {
		enabled = function() 
			-- Dont show completion for specific file types
			return not vim.tbl_contains({ "org-roam-select", "minifiles" }, vim.bo.filetype)
		end,
		keymap = { preset = 'default' },
		appearance = {
			nerd_font_variant = 'normal',
			kind_icons = {
				Class         = "",
				Color         = "",
				Constant      = "",
				Constructor   = "",
				Enum          = "",
				EnumMember    = "",
				Event         = "",
				Field         = "",
				File          = "",
				Folder        = "",
				Function      = "󰊕",
				Interface     = "",
				Keyword       = "",
				Method        = "󰊕",
				Module        = "",
				Operator      = "",
				Property      = "",
				Reference     = "",
				Snippet       = "",
				Struct        = "",
				Text          = "󰊄",
				TypeParameter = "",
				Unit          = "",
				Value         = "",
				Variable      = "",
			},
		},
		snippets = {
			preset = "luasnip",
			-- Function to use when expanding LSP provided snippets
			expand = function(snippet) vim.snippet.expand(snippet) end,
			-- Function to use when checking if a snippet is active
			active = function(filter) return vim.snippet.active(filter) end,
			-- Function to use when jumping between tab stops in a snippet, where direction can be negative or positive
			jump = function(direction) vim.snippet.jump(direction) end,
		},
		cmdline = {
			enabled = true,
			keymap = nil, -- Inherits from top level `keymap` config when not set
			sources = function()
				local type = vim.fn.getcmdtype()
				-- Search forward and backward
				if type == '/' or type == '?' then return { 'buffer' } end
				-- Commands
				if type == ':' or type == '@' then return { 'cmdline', 'path' } end
				return {}
			end,
			completion = {
				trigger = {
					show_on_blocked_trigger_characters = {},
					show_on_x_blocked_trigger_characters = nil, -- Inherits from top level `completion.trigger.show_on_blocked_trigger_characters` config when not set
				},
				menu = {
					auto_show = true, -- Inherits from top level `completion.menu.auto_show` config when not set
					draw = {
						columns = { {'kind_icon' },{ 'label', 'label_description', gap = 1 } },
					},
				}
			}
		},
		sources = {
			providers = {
				orgmode = {
					name = 'Orgmode',
					module = 'orgmode.org.autocompletion.blink',
					fallbacks = { 'buffer' },
				},
			},
			default = { 'lsp', 'path', 'snippets', 'buffer' },
			per_filetype = {
				markdown = { 'lsp', 'snippets', 'buffer', 'path' },
				org = { 'orgmode', 'buffer' }
			},
		},
		signature = {
			enabled = true,
			window = {
				scrollbar = false,
				border = "single",
				winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
			}
		},
		completion = {
			menu = {
				border = "single",
				scrollbar = true,
				winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
				draw = {
					padding = 1,
					columns = { {'kind_icon' },{ 'label', 'label_description', gap = 1 }, { 'kind' }, { 'source_name' } },
					components = {
						label = {
							width = { min = 15 }
						},
						source_name = {
							width = { max = 30 },
							-- source_name or source_id are supported
							text = function(ctx) return '(' .. ctx.source_name .. ')' end,
							highlight = 'BlinkCmpSource',
						},
					},
				}
			},
			documentation = {
				auto_show = true,
				window = {
					scrollbar = true,
					border = "single",
					winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
					direction_priority = {
						menu_north = { 'e', 'w', 'n', 's' },
						menu_south = { 'e', 'w', 's', 'n' },
					},
				}
			},
			-- Displays a preview of the selected item on the current line
			ghost_text = {
				enabled = false,
			},
		}
	},
	-- allows extending the providers array elsewhere in your config
	-- without having to redefine it
	opts_extend = { "sources.default" }
}
