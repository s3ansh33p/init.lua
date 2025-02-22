vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>w", ":%s/\\r$//<CR>", { noremap = true, silent = true })

-- Copies to clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Deletes without modifying register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Find and replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Source luasnips
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/sean/lazy/luasnip.lua<CR>")

-- Create executable bash script within vim
vim.keymap.set("n", "<leader>ch", "<cmd>!chmod +x %<CR>", { silent = true })

-- Easier source
vim.keymap.set("n", "<leader>l", function() vim.cmd("so") end)

-- Moves highlighted blocks in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- LSP remappings
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
vim.keymap.set("n", "<leader>vo", function() vim.diagnostic.open_float() end)
vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end)
vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end)
vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end)
vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end)
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end)
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end)
vim.keymap.set("n", "<leader>i", function() vim.lsp.buf.format() end)

-- Comments
vim.keymap.set("n", "<C-_>", "gcc", { noremap = true, silent = true })
vim.keymap.set("v", "<C-_>", "gc" , { noremap = true, silent = true })
