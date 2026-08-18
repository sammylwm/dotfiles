local palette = vim.fn.expand("~/.config/matugen/themes/nvim-colors.json")

return {
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
	},

	{
		"Senal-D-A-Gunaratna/matugen.nvim",
		lazy = false,
		priority = 1001,

		opts = {
			load_theme = true,
			palette_path = palette,
		},

		config = function(_, opts)
			if vim.fn.filereadable(palette) == 1 then
				require("matugen").setup(opts)
			else
				vim.cmd.colorscheme("gruvbox")
			end
		end,
	},
}
