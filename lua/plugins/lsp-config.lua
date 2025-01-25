return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "angularls@17.3.5",
        "csharp_ls@8.0.405",
      },
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      local project_library_path = "~/programming/BlueNoteWeb/webApp/angularapp/"

      local cmd = {
        "ngserver",
        "--stdio",
        "--tsProbeLocations",
        project_library_path,
        "--ngProbeLocations",
        project_library_path,
      }
      local util = require("lspconfig.util")

      lspconfig.angularls.setup({
        cmd = cmd,
        on_new_config = function(new_config, project_library_path)
          new_config.cmd = cmd
        end,
        root_dir = util.root_pattern(".git", "angular.json", "project.json"),
        capabilities = capabilities,
        filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
      })

      local project_library_path_csharp = "~/programming/BlueNoteWeb/"
      local cmd_csharp = {
        project_library_path_csharp,
      }
      lspconfig.csharp_ls.setup({
        --cmd = cmd_csharp,
        --      on_attach = on_attach,
        --root_dir = ("~/programming/BlueNoteWeb"),
        capabilities = capabilities,
      })

      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
}
