local map = vim.keymap.set

-- SMART SPLITS {{{{
map("n", '<A-h>', require('smart-splits').resize_left,  { desc = "Adjust size to left" })
map("n", '<A-j>', require('smart-splits').resize_down,  { desc = "Adjust size to left" })
map("n", '<A-k>', require('smart-splits').resize_up,    { desc = "Adjust size to left" })
map("n", '<A-l>', require('smart-splits').resize_right, { desc = "Adjust size to left" })
-- moving between splits
map("n",  '<C-h>', require('smart-splits').move_cursor_left,  { desc = "Switch to left split" })
map("n",  '<C-j>', require('smart-splits').move_cursor_down,  { desc = "Switch to below split" })
map("n",  '<C-k>', require('smart-splits').move_cursor_up,    { desc = "Switch to above split" })
map("n",  '<C-l>', require('smart-splits').move_cursor_right, { desc = "Switch to right split" })
-- }}}}

map("x",   "<leader>p",     [["_dP]],                                     { desc = "Paste Ultra Pro Max" } )
map("v",   "<leader>d",     "\"_d",                                       { desc = "Delete ultra pro max" } )
map({ "n", "v" },           "<leader>n",                                  ":norm ", { desc = "Run normal commands" } )
map("n",   "Y",             "y$",                                         { desc = "Copy text till end of line" } )
map("n",   "<leader><Esc>", ":lua vim.o.hlsearch = false<CR>",            { desc = "Disable incremental search highlighting" } )
map("n",   "<leader>rr",    [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { desc = "Replace word under the cursor globally" } )
map("n",   "<leader>xx",    "<cmd>!chmod +x %<CR>",                       { desc = "Make file executable" } )
