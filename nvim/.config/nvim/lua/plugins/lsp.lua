local setup_lsp_keymaps = require("config.keymaps").setup_lsp_keymaps

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("pyright", {
        capabilities = capabilities,
        on_attach = setup_lsp_keymaps,
      })

      vim.lsp.enable("pyright")

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        on_attach = setup_lsp_keymaps,

        settings = {
          Lua = {
            diagnostics = {
              globals = {
                "vim",
              },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      vim.lsp.enable("lua_ls")
    end,
  },
}
