return {
	"folke/snacks.nvim",
	opts = {
		picker = {
			sources = {
				explorer = {
					auto_close = true,
				},
			},
		},
	},
	keys = {
		{
			"<leader>e",
			function()
				Snacks.explorer({ cwd = vim.fn.getcwd() })
			end,
			desc = "Explorer Snacks (cwd)",
		},
	},
}
