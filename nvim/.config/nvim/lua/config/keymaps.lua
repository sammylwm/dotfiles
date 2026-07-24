vim.keymap.set("n", "<C-w>", function()
	Snacks.bufdelete()
end, { desc = "Close current file" })
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("i", "ол", "<esc>")

local setup_lsp_keymaps = function(_, bufnr)
	local opts = { buffer = bufnr }

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.jump({ count = 1 })
	end, opts)

	vim.keymap.set("n", "[d", function()
		vim.diagnostic.jump({ count = -1 })
	end, opts)
end

return {
	setup_lsp_keymaps = setup_lsp_keymaps,
}
