vim.keymap.set("n", "<tab>", "gt")
vim.keymap.set("n", "<s-tab>", "gT")
vim.keymap.set("n", "<c-w>t", ":tabnew<cr>")
vim.keymap.set("n", "<leader>t", ":term<cr>")
vim.keymap.set("n", "<leader>g", ":tabnew term://lazygit<cr>")

vim.keymap.set("n", "<", "<<")
vim.keymap.set("n", ">", ">>")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
