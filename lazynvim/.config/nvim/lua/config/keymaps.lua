local Snacks = require("snacks")

-- <leader>e -> текущая директория
vim.keymap.set("n", "<leader>e", function()
  Snacks.explorer({
    cwd = vim.fn.getcwd(),
  })
end, { desc = "Explorer (cwd)" })

-- <leader>E -> корень проекта
vim.keymap.set("n", "<leader>E", function()
  Snacks.explorer({
    cwd = require("lazyvim.util").root.get(),
  })
end, { desc = "Explorer (root)" })

local bufferline = require("bufferline")

for i = 1, 9 do
  vim.keymap.set("n", "<A-" .. i .. ">", function()
    bufferline.go_to(i, true)
  end, { desc = "Go to buffer " .. i })
end

vim.keymap.set("n", "<C-w>", function()
  Snacks.bufdelete()
end, { desc = "Close current file" })
