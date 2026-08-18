local function apply_matugen_picker_colors()
  if vim.g.colors_name ~= "matugen" then
    return
  end

  local palette_path = vim.fs.joinpath(vim.fn.stdpath("config"), "..", "matugen", "themes", "nvim-colors.json")
  local palette_file = io.open(palette_path, "r")
  if not palette_file then
    return
  end

  local ok, palette = pcall(vim.json.decode, palette_file:read("*a"))
  palette_file:close()
  if not ok or type(palette) ~= "table" then
    return
  end

  local file = { fg = palette.snacks_file or palette.on_primary_container, bold = true }
  local directory = { fg = palette.snacks_dir or palette.primary, bold = true }
  local muted = { fg = palette.on_surface_variant }

  vim.api.nvim_set_hl(0, "SnacksPickerFile", file)
  vim.api.nvim_set_hl(0, "SnacksPickerDirectory", directory)
  vim.api.nvim_set_hl(0, "SnacksPickerDir", muted)
  vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", muted)
  vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", muted)
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", file)
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored", muted)
end

return {
  "folke/snacks.nvim",
  init = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("MatugenSnacksPickerColors", { clear = true }),
      pattern = "matugen",
      callback = apply_matugen_picker_colors,
    })
    vim.schedule(apply_matugen_picker_colors)
  end,
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
