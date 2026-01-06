local capabilities = require('blink.cmp').get_lsp_capabilities()

-- A mapping from lsp server name to the executable name
local enabled_lsp_servers = {
   lua_ls = "lua-language-server",
   marksman = "marksman",
   tinymist = "tinymist",
   jdtls = "jdtls",
}

vim.lsp.config("*", {
   capabilities = capabilities
})

vim.lsp.config('tinymist',{ cmd = { 'tinymist' }, filetypes = { 'typst' }, root_markers = { '.git' }, })

vim.lsp.config("marksman",{
   cmd = { "marksman", "server" },
   filetypes = { "markdown", "markdown.mdx" },
   root_markers = { ".marksman.toml", ".git" }
})

vim.lsp.config("jdtls",{
   cmd = { "jdtls", "-configuration", "~/.cache/jdtls/config", "-data", "~/.cache/jdtls/workspace" },
   filetypes = { "java" },
   root_markers = { ".git", "build.gradle", "build.gradle.kts", "build.xml", "pom.xml", "settings.gradle", "settings.gradle.kts" }
})

vim.lsp.config('lua_ls', {
   cmd = { "lua-language-server" },
   filetypes = { "lua" },
   on_init = function(client)
      if client.workspace_folders then
         local path = client.workspace_folders[1].name
         if
            path ~= vim.fn.stdpath('config')
            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
               return
            end
         end

         client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
               -- Tell the language server which version of Lua you're using (most
               -- likely LuaJIT in the case of Neovim)
               version = 'LuaJIT',
               -- Tell the language server how to find Lua modules same way as Neovim
               -- (see `:h lua-module-load`)
               path = {
                  'lua/?.lua',
                  'lua/?/init.lua',
               },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
               checkThirdParty = false,
               library = {
                  vim.env.VIMRUNTIME
               }
            }
         })
      end,
      settings = {
         Lua = {}
      }
   })

   for server_name, _ in pairs(enabled_lsp_servers) do
      vim.lsp.enable(server_name)
   end
