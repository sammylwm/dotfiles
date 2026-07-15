-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    os.execute("hyprctl switchxkblayout all next")
  end,
})
