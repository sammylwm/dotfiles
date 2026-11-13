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
				local notify = vim.notify

				vim.notify = function(msg, ...)
					if type(msg) == "string" and msg:find("palette has 4 invalid or missing color value") then
						return
					end

					return notify(msg, ...)
				end

				require("matugen").setup(opts)

				vim.notify = notify
			else
				vim.cmd.colorscheme("gruvbox")
			end
		end,
	},
}
