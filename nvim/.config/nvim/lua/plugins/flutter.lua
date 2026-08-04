return {
  {
    "nvim-flutter/flutter-tools.nvim",
    ft = "dart",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    keys = {
      { "<leader>Fr", "<cmd>FlutterRun<cr>", desc = "Flutter run" },
      { "<leader>FR", "<cmd>FlutterRestart<cr>", desc = "Flutter restart" },
      { "<leader>Fl", "<cmd>FlutterReload<cr>", desc = "Flutter hot reload" },
      { "<leader>Fd", "<cmd>FlutterDevices<cr>", desc = "Flutter devices" },
      { "<leader>Fe", "<cmd>FlutterEmulators<cr>", desc = "Flutter emulators" },
      { "<leader>Fo", "<cmd>FlutterOutlineToggle<cr>", desc = "Flutter outline" },
      { "<leader>Fq", "<cmd>FlutterQuit<cr>", desc = "Flutter quit" },
    },
    opts = {
      root_patterns = { "pubspec.yaml", ".git" },
      ui = { border = "rounded" },
      widget_guides = { enabled = true },
      closing_tags = { enabled = true },
      dev_log = {
        enabled = true,
        notify_errors = true,
        focus_on_open = false,
      },
      lsp = {
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = "prompt",
          updateImportsOnRename = true,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      if not vim.tbl_contains(opts.ensure_installed, "dart") then
        table.insert(opts.ensure_installed, "dart")
      end
    end,
  },
}
