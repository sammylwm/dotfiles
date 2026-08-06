local ensure_installed = {
  "lua-language-server",
  "pyright",
  "kotlin-lsp",
}

local installed_package_names = require("mason-registry").get_installed_package_names()
for _, v in ipairs(ensure_installed) do
  if not vim.tbl_contains(installed_package_names, v) then
    vim.cmd(":MasonInstall " .. v)
  end
end

vim.lsp.config("qml-language-server", {
  cmd = { "qml-language-server" },
  filetypes = { "qml" },
  root_markers = { { "qmldir", "shell.qml" }, ".git" },
})

local installed_packages = require("mason-registry").get_installed_packages()
local installed_lsp_names = vim.iter(installed_packages):fold({}, function(acc, pack)
  table.insert(acc, pack.spec.neovim and pack.spec.neovim.lspconfig)
  return acc
end)

vim.lsp.enable(installed_lsp_names)
vim.lsp.enable("qml-language-server")
