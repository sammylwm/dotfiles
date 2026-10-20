return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local bufferline = require("bufferline")

		for i = 1, 9 do
			vim.keymap.set("n", "<A-" .. i .. ">", function()
				bufferline.go_to(i, true)
			end, {
				desc = "Go to buffer " .. i,
			})
		end

		bufferline.setup({})
	end,
}
