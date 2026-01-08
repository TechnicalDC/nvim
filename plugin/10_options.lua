local set = vim.opt

set.mouse       = 'a'            -- Enable mouse
-- UI =========================================================================
set.breakindent    = true       -- Indent wrapped lines to match line start
set.breakindentopt = 'list:-1'  -- Add padding for lists (if 'wrap' is set)
set.colorcolumn    = '+1'       -- Draw column on the right of maximum width
set.cursorline     = true       -- Enable current line highlighting
set.linebreak      = true       -- Wrap lines at 'breakat' (if 'wrap' is set)
set.list           = true       -- Show helpful text indicators
set.number         = true       -- Show line numbers
set.relativenumber = true       -- Show relative line numbers
set.pumheight      = 10         -- Make popup menu smaller
set.ruler          = false      -- Don't show cursor coordinates
set.shortmess      = 'CFOSWaco' -- Disable some built-in completion messages
set.showmode       = false      -- Don't show mode in command line
set.showmatch      = true
set.splitbelow     = true       -- Horizontal splits will be below
set.splitkeep      = 'screen'   -- Reduce scroll during window split
set.splitright     = true       -- Vertical splits will be to the right
set.winborder      = 'single'   -- Use border in floating windows
set.wrap           = false      -- Don't visually wrap lines (toggle with \w)
set.cursorlineopt  = 'screenline,number' -- Show cursor line per screen line
set.showtabline    = 2
set.laststatus     = 3
set.wildmenu       = true
set.wildmode       = "longest:full,list:full"
set.wildignore     = "*.o,*.obj,*.bak,*.exe,*.hi,*.dyn_hi,*.dyn_o,*.zip,*.pdf,*.gif,*.png,*.jpg,*.mp4,*mp3"
set.foldenable     = false
set.foldcolumn     = "0"
set.foldmethod     = "marker"
set.foldmarker     = "{{{,}}}"
set.foldexpr       = "v:lua.vim.treesitter.foldexpr()"
set.helpheight   = 15
set.statuscolumn = "%s%=%{v:relnum ? v:relnum : v:lnum} "

-- Special UI symbols. More is set via 'mini.basics' later.
set.fillchars:append({
   fold      = "─",
   foldopen  = "",
   foldclose = "",
   diff      = "-",
   eob       = " ",
	horiz     = '═',
	horizup   = '╩',
	horizdown = '╦',
	vert      = '║',
	vertleft  = '╣',
	vertright = '╠',
	verthoriz = '╬',
})

set.listchars = "eol: "
   .. ",tab:┊ "
   .. ",nbsp:␣"
   .. ",lead: "
   .. ",leadmultispace: "
   .. ",extends:>"
   .. ",precedes:<"


-- Editing ====================================================================
set.clipboard      = "unnamedplus"
set.encoding       = "UTF-8"
set.autoindent    = true    -- Use auto indent
set.expandtab     = true    -- Convert tabs to spaces
set.formatoptions = 'rqnl1j'-- Improve comment editing
set.ignorecase    = true    -- Ignore case during search
set.incsearch     = true    -- Show search matches while typing
set.infercase     = true    -- Infer case in built-in completion
set.shiftwidth    = 3       -- Use this number of spaces for indentation
set.smartcase     = true    -- Respect case if search pattern has upper case
set.smartindent   = true    -- Make indenting smart
set.spelloptions  = 'camel' -- Treat camelCase word parts as separate words
set.tabstop       = 3       -- Show tab as this number of spaces
set.virtualedit   = 'block' -- Allow going past end of line in blockwise mode
set.swapfile       = false
set.spelllang     = "en_us"
set.signcolumn    = "auto:1"
set.conceallevel  = 2
set.concealcursor = 'nc'

-- SHELL {{{
if vim.fn.has("win32") == 1 then
   set.shell = vim.fn.executable "powershell" == 1 and "powershell" or "pwsh"
   set.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
   set.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
   set.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
   set.shellquote = ""
   set.shellxquote = ""
else
   set.shell = "fish"
end
-- }}}

vim.filetype.add({
   pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
   extension = {
      rasi = "css",
      tex = "tex",
      md = "markdown",
      i = "progress",
      p = "progress",
      cls = "progress",
   }
})

vim.diagnostic.config({
   underline = true,
   severity_sort = true,
   virtual_text = false,
   signs = {
      text = {
         [vim.diagnostic.severity.INFO]  = '',
         [vim.diagnostic.severity.WARN]  = '',
         [vim.diagnostic.severity.HINT]  = '󰌵',
         [vim.diagnostic.severity.ERROR] = '',
      }
   }
})

