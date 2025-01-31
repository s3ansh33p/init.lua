vim.g.mapleader = " "
vim.keymap.set("n", "<leader>v", vim.cmd.Ex)
vim.keymap.set("n", "<leader>s", ":%s/\\r$//<CR>", { noremap = true, silent = true })