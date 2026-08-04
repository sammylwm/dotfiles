local function toggle_codex()
  require("codex").toggle()

  vim.schedule(function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("startinsert")
    end
  end)
end

return {
  "kkrampis/codex.nvim",
  lazy = true,
  cmd = { "Codex", "CodexToggle" },

  keys = {
    {
      "<A-c>",
      toggle_codex,
      desc = "Toggle Codex popup or side-panel",
      mode = { "n", "t" },
    },
    {
      "<A-с>",
      toggle_codex,
      desc = "Toggle Codex popup or side-panel (Russian layout)",
      mode = { "n", "t" },
    },
  },

  opts = {
    keymaps = {
      toggle = nil,
      quit = "<C-q>",
    },
    border = "rounded",
    width = 0.8,
    height = 0.8,
    model = nil,
    autoinstall = true,
    panel = false,
    use_buffer = false,
  },
}
