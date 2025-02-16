return {
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      local work_path = "C:/Projekter/renomatic/Angular/renomatic/"
      local personal_path = "~/programming/BlueNoteWeb/webApp/angularapp/"

      local current_dir = vim.fn.getcwd()

      if current_dir == personal_path then
        null_ls.setup({
          sources = {
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.formatting.csharpier,
          },
        })
      end

      if current_dir == work_path then
        null_ls.setup({
          sources = {
            null_ls.builtins.formatting.stylua,
            require("none-ls.diagnostics.eslint"),
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.formatting.csharpier,
          },
        })
      end

      vim.keymap.set({ "n", "v" }, "<leader>gf", function()
        local clients = vim.lsp.get_clients({ bufnr = bufnr })
        local formatters = {}

        for _, c in pairs(clients) do
          if c.server_capabilities.documentFormattingProvider then
            table.insert(formatters, c.name)
          end
        end

        if #formatters > 1 then
          vim.ui.select(formatters, { prompt = "Select a formatter" }, function(_, choice)
            if not choice then
              print("No formatter selected")
              return
            end

            local formatter = formatters[choice]
            vim.lsp.buf.format({ async = true, name = formatter })
          end)
        else
          vim.lsp.buf.format({ async = true, name = formatters[1] })
        end
      end, bufopts)
    end,
  },
  {
    "nvimtools/none-ls-extras.nvim",
  },
}
