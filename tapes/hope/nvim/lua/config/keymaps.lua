vim.keymap.set("n", "<C-w>", function()
	Snacks.bufdelete()
end, { desc = "Close current file" })

vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("n", "<leader>w", vim.diagnostic.open_float)
