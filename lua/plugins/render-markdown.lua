return {
	'MeanderingProgrammer/render-markdown.nvim',
	dependencies = { 'nvim-treesitter/nvim-treesitter' },
	ft = "markdown",
	config = function ()
		local render = require('render-markdown')

		render.setup({
			file_types = { 'markdown' },
			render_modes = true,
			anti_conceal = { enabled = true },
			heading = {
				border = false,
				sign = true,
				left_pad = 1,
				right_pad = 1,
				width = "block",
				position = "inline",
				foregrounds = {
					'RenderMarkdownH1',
					'RenderMarkdownH2',
					'RenderMarkdownH3',
					'RenderMarkdownH4',
					'RenderMarkdownH5',
					'RenderMarkdownH6',
				},
			},
			code = {
				width = 'block',
				left_pad = 2,
				right_pad = 2,
				sign = false,
				border = 'thick',
			},
			quote = { icon = '▌' },
			bullet = {
				enabled = true,
				icons = {'•'},
			},
			dash = { enabled = true },
			completions = {
				blink = { enabled = true },
				lsp = { enabled = true }
			},
			link = {
				hyperlink = '󰌷 ',
				wiki = { icon = "" },
				custom = {
					web = { pattern = '^http', icon = '󰖟 ' },
					github = { pattern = 'github%.com', icon = '󰊤 ' },
					gitlab = { pattern = 'gitlab%.com', icon = '󰮠 ' },
					google = { pattern = 'google%.com', icon = '󰊭 ' },
					linkedin = { pattern = 'linkedin%.com', icon = '󰌻 ' },
					neovim = { pattern = 'neovim%.org', icon = ' ' },
					reddit = { pattern = 'reddit%.com', icon = '󰑍 ' },
					stackoverflow = { pattern = 'stackoverflow%.com', icon = '󰓌 ' },
					wikipedia = { pattern = 'wikipedia%.org', icon = '󰖬 ' },
					youtube = { pattern = 'youtube[^.]*%.com', icon = '󰗃 ' },
					youtube_short = { pattern = 'youtu%.be', icon = '󰗃 ' },
				},
			},
			pipe_table = {
				preset = 'none',
				cell = 'trimmed',
				filler = 'RenderMarkdownTableRow',
				border = {
					'┌', '┬', '┐',
					'├', '┼', '┤',
					'└', '┴', '┘',
					'│', '─',
				},
			},
			checkbox = {
				checked = { icon = '󰄵' },
				unchecked = { icon = '󰄱' },
				custom = {
					todo = {
						raw = '[-]',
						rendered = '',
						highlight = 'RenderMarkdownTodo',
						scope_highlight = nil
					},
					important = {
						raw = '[!]',
						rendered = '󰓎',
						highlight = 'DiagnosticWarn',
					},
				},
			},
		})
	end
}
