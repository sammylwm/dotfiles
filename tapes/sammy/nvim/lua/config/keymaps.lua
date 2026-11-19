vim.keymap.set("n", "<C-w>", function()
	Snacks.bufdelete()
end, { desc = "Close current file" })

vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("n", "<leader>w", vim.diagnostic.open_float)

vim.keymap.set("n", "<leader>i", function()
	vim.lsp.buf.code_action({
		context = { only = { "quickfix" } },
		apply = true,
	})
end, { desc = "Dart: import / quick fix" })
