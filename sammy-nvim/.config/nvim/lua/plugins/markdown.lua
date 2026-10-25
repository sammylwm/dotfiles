return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		anti_conceal = {
			enabled = false,
		},
		win_options = {
			conceallevel = {
				rendered = 3,
			},
			concealcursor = {
				rendered = "nvic",
			},
		},
		heading = {
			enabled = true,
		},
		code = {
			enabled = true,
		},
	},
}
