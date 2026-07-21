vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set(:w)
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    os.execute("hyprctl switchxkblayout all 0")
  end,
})
vim.opt.clipboard = "unnamedplus"

