return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local on_attach = function(_, bufnr)
      local function bufmap(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, {
          buffer = bufnr,
          silent = true,
        })
      end

      bufmap("n", "gd", vim.lsp.buf.definition)
      bufmap("n", "K", vim.lsp.buf.hover)
      bufmap("n", "<leader>rn", vim.lsp.buf.rename)
      bufmap("n", "<leader>ca", vim.lsp.buf.code_action)
      bufmap("n", "[d", vim.diagnostic.goto_prev)
      bufmap("n", "]d", vim.diagnostic.goto_next)
      bufmap("n", "gl", vim.diagnostic.open_float)
    end

    local servers = {
      "pyright",
      "rust_analyzer",
      "clangd",
      "qmlls6"
    }

    for _, server in ipairs(servers) do
      vim.lsp.config(server, {
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end

    -- QML / Qt Quick / Quickshell
    vim.lsp.config("qmlls", {
      cmd = {
        "qmlls",
        "-I",
        "/usr/lib/qt6/qml",
      },
      filetypes = { "qml", "qmljs" },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- Включаем серверы
    vim.lsp.enable(servers)
    vim.lsp.enable("qmlls")
  end,
}
