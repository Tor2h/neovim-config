return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local machine = "work"
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.csharpier,
				},
			})

			if machine == "work" then
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
			-- vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},
	{
		"nvimtools/none-ls-extras.nvim",
	},
}
