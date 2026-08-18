return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = { "ToggleTerm", "TermExec" },
	keys = {
		{
			"<C-/>",
			"<cmd>ToggleTerm<cr>",
			mode = { "n", "t" },
			desc = "Toggle terminal",
		},
		{
			"<C-_>",
			"<cmd>ToggleTerm<cr>",
			mode = { "n", "t" },
			desc = "Toggle terminal (fallback)",
		},
	},
	opts = {
		open_mapping = { [[<C-/>]], [[<C-_>]] },
		direction = "float",
		start_in_insert = true,
		insert_mappings = false,
		terminal_mappings = true,
		close_on_exit = true,
		float_opts = {
			border = "rounded",
		},
	},
}
