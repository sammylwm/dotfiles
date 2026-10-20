vim.keymap.set("n", "<C-w>", function()
	Snacks.bufdelete()
end, { desc = "Close current file" })

vim.keymap.set("i", "jk", "<esc>")
